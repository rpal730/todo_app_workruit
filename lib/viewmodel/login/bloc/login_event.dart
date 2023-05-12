part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginProcessing extends LoginEvent {
  final String email;
  final String password;
  final bool rememberMe;

  LoginProcessing(
      {required this.email, required this.password, required this.rememberMe});

  List<Object> get props => [email, password, rememberMe];
}
