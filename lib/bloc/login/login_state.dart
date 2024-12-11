import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSucess extends LoginState {
  final User user;
  LoginSucess({required this.user});
}

class LoginFailure extends LoginState {
  final String message;
  LoginFailure({required this.message});
}
