abstract class RegisterEvent {}

class RegisterUserEvent extends RegisterEvent {
  final String email;
  final String password;
  final String confirmPassword;
  RegisterUserEvent(
      {required this.email,
      required this.password,
      required this.confirmPassword});
}
