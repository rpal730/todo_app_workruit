import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:todo_app_workruit/repositories/user_repository.dart';
import 'package:todo_app_workruit/utils/exceptions.dart';
import 'package:todo_app_workruit/utils/validator.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final UserRepository userRepository;
  SignupBloc(this.userRepository) : super(SignupInitial()) {
    on<SignupEvent>((event, emit) {});

    on<SignupProcessing>(_performSignup);
  }

  FutureOr<void> _performSignup(
      SignupProcessing event, Emitter<SignupState> emit) async {
    emit(SignupLoading());
    try {
      _validatePerformSignupInputs(event);
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: event.email, password: event.password);

      await userRepository.addUser(
          userId: userCredential.user!.uid,
          email: event.email,
          name: event.name);
      emit(SignupSuccess());
    } on FirebaseAuthException catch (e) {
      emit(SignupFailed(e.toString()));
    } on CustomException catch (e) {
      emit(SignupFailed(e.toString()));
    } on Exception catch (e) {
      print(e.toString());
      emit(SignupFailed('Something went wrong'));
    }
  }

  void _validatePerformSignupInputs(SignupProcessing input) {
    if (input.name.isEmpty ||
        input.email.isEmpty ||
        input.password.isEmpty ||
        input.confirmPassword.isEmpty) {
      throw const CustomException(message: 'every field is required');
    }

    if (!Validator.validateName(input.name)) {
      throw const CustomException(message: 'Invalid name');
    }

    if (!Validator.validateEmail(input.email)) {
      throw const CustomException(message: 'Invalid email');
    }

    if (input.password != input.confirmPassword) {
      throw const CustomException(message: 'Password is not same');
    }
  }
}
