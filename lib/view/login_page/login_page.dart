import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app_workruit/utils/ui_helper.dart';
import 'package:todo_app_workruit/view/custom_widgets/custom_processing_button.dart';
import 'package:todo_app_workruit/view/custom_widgets/custom_textfield.dart';
import 'package:todo_app_workruit/view/homepage/homepage.dart';
import 'package:todo_app_workruit/viewmodel/login/bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginBloc _bloc;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  void _listenLoginBloc(BuildContext context, LoginState state) {
    if (state is LoginSuccess) {
      context.goNamed(Homepage.routeName);
      // context.pushReplacementNamed(Homepage.routeName);
      showSuccessSnackbar(context, 'Successfully Logged in !!');
    } else if (state is LoginFailed) {
      showErrorSnackbar(context, state.message);
    }
  }

  void _performSignin() {
    _bloc.add(
      LoginProcessing(
        email: emailController.text.trim(),
        password: passwordController.text,
        rememberMe: rememberMe,
      ),
    );
  }

  @override
  void initState() {
    _bloc = LoginBloc();
    super.initState();
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
              //--------------------------
              const SizedBox.square(dimension: 30),
              const Text(
                'Login.',
                style: TextStyle(fontSize: 50),
              ),
              CustomTextField(
                controller: emailController,
                hint: 'Enter email',
                title: 'Email-id',
              ),
              const SizedBox.square(dimension: 10),
              CustomTextField(
                controller: passwordController,
                hint: 'Enter password',
                obscureText: true,
                title: 'Password',
              ),
              Row(
                children: [
                  //-------------------check box
                  Checkbox(
                      value: rememberMe,
                      onChanged: (value) {
                        rememberMe = value ?? false;
                        setState(() {});
                      }),
                  const Text('Remember me'),
                ],
              ),
              const SizedBox.square(dimension: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: CustomProcessingButton(
                        onPressed: () {
                          context.pop();
                        },
                        title: 'Back'),
                  ),
                  const SizedBox.square(dimension: 10),
                  Flexible(
                    child: BlocConsumer<LoginBloc, LoginState>(
                      bloc: _bloc,
                      listener: _listenLoginBloc,
                      builder: (context, state) {
                        return CustomProcessingButton(
                          isProcessing: state is LoginLoading,
                          backgroundColor: Colors.blueGrey,
                          onPressed: _performSignin,
                          title: ('SUBMIT'),
                        );
                      },
                    ),
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
