import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app_workruit/view/custom_widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(hint: 'Enter email',),
          CustomTextField(hint: 'Enter password',obscureText: true,),
          
          SizedBox.square(
            dimension: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text('Back')),
              ElevatedButton(onPressed: () {}, child: Text('SUBMIT'))
            ],
          )
        ],
      )),
    );
  }
}
