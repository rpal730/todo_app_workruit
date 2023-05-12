import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app_workruit/view/custom_widgets/custom_processing_button.dart';
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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'TO - DO',
                  style: TextStyle(fontSize: 40),
                ),
                const SizedBox.square(
                  dimension: 10,
                ),
                const Text(
                  'a simple to-do list maker, only for you',
                  style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
                ),
                const SizedBox.square(
                  dimension: 70,
                ),
                CustomProcessingButton(
                    backgroundColor: Colors.blueGrey,
                    onPressed: () {
                      context.pushNamed(LoginPage.routeName);
                    },
                    title: ('Login')),
                const SizedBox.square(
                  dimension: 20,
                ),
                CustomProcessingButton(
                    onPressed: () {
                      context.pushNamed(SignUpPage.routeName);
                    },
                    title: ('SignUp')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
