import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app_workruit/view/login_page/login_page.dart';
import 'package:todo_app_workruit/view/sign_up_page.dart/sign_up_page.dart';

class LandingPage extends StatefulWidget {
  static const String routeName = '/';
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    context.pushNamed(LoginPage.routeName);
                  },
                  child: const Text('Login')),
              ElevatedButton(
                  onPressed: () {
                    context.pushNamed(SignUpPage.routeName);
                  },
                  child: const Text('SignUp')),
            ],
          ),
        ),
      ),
    );
  }
}
