import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app_workruit/repositories/user_repository.dart';
import 'package:todo_app_workruit/utils/ui_helper.dart';
import 'package:todo_app_workruit/view/custom_widgets/custom_processing_button.dart';
import 'package:todo_app_workruit/view/custom_widgets/custom_textfield.dart';
import 'package:todo_app_workruit/viewmodel/signup/bloc/signup_bloc.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/signup';
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final SignupBloc _bloc;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void _listenSignupBloc(BuildContext context, SignupState state) {
    if (state is SignupSuccess) {
      context.pop();
      showSuccessSnackbar(context, 'Successfully signup !');
    } else if (state is SignupFailed) {
      showErrorSnackbar(context, state.message);
    }
  }

  void _performSignin() {
    _bloc.add(
      SignupProcessing(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
      ),
    );
  }

  @override
  void initState() {
    _bloc = SignupBloc(context.read<UserRepository>());
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();

    nameController.dispose;
    emailController.dispose;
    passwordController.dispose;
    confirmPasswordController.dispose;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox.square(dimension: 30),
              Text(
                'SignUp.',
                style: TextStyle(fontSize: 50),
              ),
              CustomTextField(
                controller: nameController,
                hint: 'Enter name',
                title: 'Name',
              ),
              const SizedBox.square(dimension: 10),
              CustomTextField(
                controller: emailController,
                hint: 'Enter email',
                title: 'Email-id',
              ),
              const SizedBox.square(dimension: 10),
              CustomTextField(
                controller: passwordController,
                hint: 'Enter password',
                title: 'Password',
                obscureText: true,
              ),
              const SizedBox.square(dimension: 10),
              CustomTextField(
                controller: confirmPasswordController,
                hint: 'Re-enter password',
                title: 'Confirm Password',
                obscureText: true,
              ),
              const SizedBox.square(dimension: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: CustomProcessingButton(
                      title: 'Back',
                      onPressed: () {
                        context.pop();
                      },
                    ),
                  ),
                  const SizedBox.square(dimension: 10),
                  BlocConsumer<SignupBloc, SignupState>(
                    bloc: _bloc,
                    listener: _listenSignupBloc,
                    builder: (context, state) {
                      return Flexible(
                        child: CustomProcessingButton(
                          onPressed: _performSignin,
                          title: 'SUBMIT',
                          backgroundColor: Colors.blueGrey,
                          isProcessing: state is SignupLoading,
                        ),
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
