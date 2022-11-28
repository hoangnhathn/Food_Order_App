import 'package:flutter/material.dart';

import '../page/authentication/login/login_page.dart';
import '../page/authentication/sign_up/sign_up_page.dart';
import '../page/category/category_page.dart';
import '../page/home/home_page.dart';
import '../page/splash/splash_page.dart';
import 'app_route.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.splashPage:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const SplashPage(),
        );
      case AppRoute.loginPage:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const LoginPage(),
        );
      case AppRoute.signUpPage:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const SignUpPage(),
        );
      case AppRoute.homePage:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const HomePage(),
        );
      case AppRoute.categoryPage:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const CategoryPage(),
        );
    }
    return null;
  }
}
