import 'package:go_router/go_router.dart';
import 'package:todo_app_workruit/view/landing_page/landing_page.dart';

final GoRouter router = GoRouter(
  initialLocation: LandingPage.routeName,
  
  
  
  routes: [ 
    GoRoute(
      name: LandingPage.routeName,
      path: LandingPage.routeName,
      builder: (context, state) => const LandingPage(),

    ),

]);