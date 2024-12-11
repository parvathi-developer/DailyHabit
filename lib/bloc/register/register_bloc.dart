import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_app/bloc/register/register_event.dart';
import 'package:habit_app/bloc/register/register_state.dart';
import 'package:habit_app/utility/util.dart';
import 'package:uuid/uuid.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Uuid _uuid = Uuid();
  RegisterBloc() : super(RegisterInitialState()) {
    on<RegisterUserEvent>(_onRegisterEvent);
  }

  FutureOr<void> _onRegisterEvent(
      RegisterUserEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoadingState());
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: event.email.trim(), password: event.password.trim());

      String uniqueId = _uuid.v4();
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'email': event.email,
        'uniqueId': uniqueId,
        'serverTime': FieldValue.serverTimestamp()
      });

      await Util.saveUserId(userCredential.user?.uid);
      await Util.saveUserLogged(true);

      emit(RegisterSuccessState(email: userCredential.user?.email ?? ''));
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'weak-password':
          message = 'The password provided is two weak';
          break;
        case 'email-already-in-use':
          message = 'An account already exist for this email';
          break;
        default:
          message = 'Registration failed ${e.message}';
      }
      emit(RegisterFailureState(message: message));
    }
  }
}
