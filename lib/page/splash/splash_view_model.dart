import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/splash_repository/splash_repository.dart';
import 'splash_state.dart';

class SplashViewModel extends StateNotifier<SplashState> {
  SplashViewModel({
    required this.repository,
    required this.read,
  }) : super(SplashState.initial());

  final SplashRepository repository;

  final Ref read;

  Future<void> init() async {
    await repository.isFirstOpenApp();
  }

  Future<bool> authenticateApp() async {
    return true;
  }
}
