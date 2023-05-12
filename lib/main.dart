import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_workruit/config/app_router.dart';
import 'package:todo_app_workruit/firebase_options.dart';
import 'package:todo_app_workruit/repositories/user_repository.dart';
import 'package:todo_app_workruit/view/homepage/homepage.dart';
import 'package:todo_app_workruit/view/landing_page/landing_page.dart';
import 'package:todo_app_workruit/viewmodel/login/bloc/login_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final prefs = await SharedPreferences.getInstance();
  final rememberMe = prefs.getBool('rememberMe') ?? false;
  print('-----ssf-------');
  runApp(MyApp(
    rememberMe: rememberMe,
  ));

  print('-----sadsa--------');
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
    print('-----------');
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => UserRepository(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => LoginBloc()),
          ],
          child: MaterialApp.router(
            theme: ThemeData.dark(),
            routerConfig: GoRouter(
                initialLocation: (widget.rememberMe &&
                        FirebaseAuth.instance.currentUser != null)
                    ? Homepage.routeName
                    : LandingPage.routeName,
                routes: routes),
          ),
        ));
  }
}
