import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app_workruit/view/add_task/add_task.dart';
import 'package:todo_app_workruit/view/homepage/homepage.dart';
import 'package:todo_app_workruit/view/landing_page/landing_page.dart';
import 'package:todo_app_workruit/view/login_page/login_page.dart';
import 'package:todo_app_workruit/view/sign_up_page.dart/sign_up_page.dart';

final routes = [
  GoRoute(
    name: LandingPage.routeName,
    path: LandingPage.routeName,
    builder: (context, state) => const LandingPage(),
  ),
  GoRoute(
    name: SignUpPage.routeName,
    path: SignUpPage.routeName,
    builder: (context, state) => const SignUpPage(),
  ),
  GoRoute(
    name: LoginPage.routeName,
    path: LoginPage.routeName,
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    name: Homepage.routeName,
    path: Homepage.routeName,
    builder: (context, state) => const Homepage(),
  ),
  GoRoute(
    name: AddTask.routeName,
    path: AddTask.routeName,
    builder: (context, state) => const AddTask(),
  ),
];
