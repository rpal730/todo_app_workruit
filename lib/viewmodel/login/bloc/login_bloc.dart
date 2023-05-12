import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_workruit/utils/exceptions.dart';
import 'package:todo_app_workruit/utils/validator.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
    on<LoginProcessing>(_loginProcessing);
  }

  _loginProcessing(LoginProcessing event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      _validateLoginInputs(event);

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: event.email, password: event.password);

      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('rememberMe', event.rememberMe);

      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      emit(LoginFailed(e.toString()));
    } on CustomException catch (e) {
      emit(LoginFailed(e.message));
    } on Exception {
      emit(LoginFailed('Something went wrong'));
    }
  }

  void _validateLoginInputs(LoginProcessing event) {
    if (event.email.isEmpty) {
      throw const CustomException(message: 'Empty email');
    }

    if (!Validator.validateEmail(event.email)) {
      throw const CustomException(message: 'Invalid email');
    }

    if (!Validator.validatePassword(event.password)) {
      throw const CustomException(message: 'Invalid password');
    }
  }
}
