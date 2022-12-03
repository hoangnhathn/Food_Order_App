import 'package:flutter/material.dart';

import '../page/authentication/login/login_page.dart';
import '../page/authentication/sign_up/sign_up_page.dart';
import '../page/food_detail/top/food_detail_top_page.dart';
import '../page/food_detail/top/model/food_detail_top_arguments.dart';
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
      case AppRoute.foodDetailPage:
        return MaterialPageRoute(
          builder: (context) => FoodDetailPage(
            arguments: settings.arguments as FoodDetailTopArguments,
          ),
        );
    }
    return null;
  }
}
