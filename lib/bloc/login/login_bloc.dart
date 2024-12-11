import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_app/bloc/login/login_event.dart';
import 'package:habit_app/bloc/login/login_state.dart';
import 'package:habit_app/utility/util.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  FutureOr<void> _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
              email: event.email, password: event.password);

      await Util.saveUserId(userCredential.user?.uid);
      await Util.saveUserLogged(true);

      emit(LoginSucess(user: userCredential.user!));
    } on FirebaseAuthException catch (e) {
      emit(LoginFailure(message: e.toString()));
    }
  }
}
