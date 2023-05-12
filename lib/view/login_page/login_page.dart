import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app_workruit/view/custom_widgets/custom_processing_button.dart';
import 'package:todo_app_workruit/view/custom_widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
              SizedBox.square(dimension: 10),
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
                      child: CustomProcessingButton(
                          backgroundColor: Colors.blueGrey,
                          onPressed: () {},
                          title: ('SUBMIT')))
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
