import 'package:flutter/material.dart';

import '../page/authentication/login/login_page.dart';
import '../page/authentication/sign_up/sign_up_page.dart';
import '../page/cart_list/cart_list_page.dart';
import '../page/category/category_page.dart';
import '../page/food_detail/final_confirm_order/final_confirm_order_page.dart';
import '../page/food_detail/final_confirm_order/model/final_confirm_order_arguments.dart';
import '../page/food_detail/order/food_detail_order_page.dart';
import '../page/food_detail/order/model/food_detail_order_arguments.dart';
import '../page/food_detail/top/food_detail_top_page.dart';
import '../page/food_detail/top/model/food_detail_top_arguments.dart';
import '../page/home/home_page.dart';
import '../page/profile/profile_page.dart';
import '../page/search_list/model/search_list_arguments.dart';
import '../page/search_list/search_list_page.dart';
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
      case AppRoute.foodDetailPage:
        return MaterialPageRoute(
          builder: (context) => FoodDetailPage(
            arguments: settings.arguments as FoodDetailTopArguments,
          ),
        );
      case AppRoute.foodDetailOrderPage:
        return MaterialPageRoute(
          builder: (context) => FoodDetailOrderPage(
            arguments: settings.arguments as FoodDetailOrderArguments,
          ),
        );
      case AppRoute.finalConfirmationOrderPage:
        return MaterialPageRoute(
          builder: (context) => FinalConfirmOrderPage(
            arguments: settings.arguments as FinalConfirmOrderArguments,
          ),
        );
      case AppRoute.cartListPage:
        return MaterialPageRoute(
          builder: (context) => const CartListPage(),
        );
      case AppRoute.searchListPage:
        return MaterialPageRoute(
          builder: (context) => SearchListPage(
            arguments: settings.arguments as SearchListArguments,
          ),
        );
      case AppRoute.profilePage:
        return MaterialPageRoute(
          builder: (context) => const ProfilePage(),
        );
    }
    return null;
  }
}
