import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'splash_state.dart';

final splashViewModel = StateNotifierProvider<SplashViewModel, SplashState>(
  (ref) => SplashViewModel(read: ref),
);

class SplashViewModel extends StateNotifier<SplashState> {
  SplashViewModel({
    required this.read,
  }) : super(SplashState.initial());

  final Ref read;

  void init() {}

  Future<bool> authenticateApp() async {
    return true;
  }
}
