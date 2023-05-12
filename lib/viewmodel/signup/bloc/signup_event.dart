part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent {}

class SignupProcessing extends SignupEvent {
  final String email;
  final String name;
  final String password;
  final String confirmPassword;

  SignupProcessing({
    required this.email,
    required this.name,
    required this.password,
    required this.confirmPassword,
  });

  List<Object> get props => [name, email, password, confirmPassword];
}
