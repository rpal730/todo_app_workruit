import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_workruit/config/app_router.dart';
import 'package:todo_app_workruit/repositories/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  final rememberMe = prefs.getBool('rememberMe') ?? false;
  runApp(MyApp(
    rememberMe: rememberMe,
  ));
}

class MyApp extends StatefulWidget {
  final bool rememberMe;
  const MyApp({super.key, required this.rememberMe});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [RepositoryProvider(create: (context) => UserRepository())],
        child: MultiBlocProvider(
          providers: [],
          child: MaterialApp.router(
            routerConfig: router,
          ),
        ));
  }
}
