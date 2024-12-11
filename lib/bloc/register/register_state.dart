abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final String email;
  RegisterSuccessState({required this.email});
}

class RegisterFailureState extends RegisterState {
  final String message;
  RegisterFailureState({required this.message});
}
