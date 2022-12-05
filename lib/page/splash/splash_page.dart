import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common_widgets/base/base_page.dart';
import '../../common_widgets/logo_image.dart';
import '../../data/provider/app_navigator_provider.dart';
import '../../data/repository/splash_repository/splash_repository.dart';
import '../../navigation/app_route.dart';
import 'splash_state.dart';
import 'splash_view_model.dart';

final _provider = StateNotifierProvider<SplashViewModel, SplashState>(
  (ref) => SplashViewModel(
    repository: SplashRepository(ref),
    read: ref,
  ),
);

class SplashPage extends BasePage {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends BasePageState<SplashPage> {
  @override
  void onInitState() {
    super.onInitState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(_provider.notifier).init();
    });

    Future.delayed(
      const Duration(seconds: 3),
      () {
        onAuthenticate();
      },
    );
  }

  @override
  Widget body(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        tileMode: TileMode.mirror,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.pink.shade200,
                          Colors.red.shade300,
                        ],
                      ),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5,
                        sigmaY: 5,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: const [
                    Expanded(
                      child: Center(
                        child: LogoImage(
                          size: 80,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onAuthenticate() async {
    final isAuthenticated =
        await ref.read(_provider.notifier).authenticateApp();
    if (isAuthenticated) {
      await ref.read(appNavigatorProvider).navigateTo(
            AppRoute.loginPage,
            shouldClearStack: true,
          );
    } else {
      await ref.read(appNavigatorProvider).navigateTo(
            AppRoute.loginPage,
            shouldClearStack: true,
          );
    }
  }
}
