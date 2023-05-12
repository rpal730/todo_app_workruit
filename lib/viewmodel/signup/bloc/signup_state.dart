part of 'signup_bloc.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {}

class SignupFailed extends SignupState {
  final String message;

  SignupFailed(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}
