import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// [AppNavigatorAction] is enum of status navigator
enum AppNavigatorAction {
  /// Keep All Of Stacks
  keep,

  /// Replace Last Stacks
  replace,

  /// Remove all Stacks
  removeAll,
}

class AppNavigator {
  AppNavigator({
    required this.read,
  });

  final Ref read;

  final navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(
      String routeName, {
        Object? arguments,
        bool shouldClearStack = false,
      }) async {
    final currentState = navigatorKey.currentState;

    if (currentState == null) {
      return false;
    }

    if (shouldClearStack) {
      /// Push the route with the given name
      await currentState.pushNamedAndRemoveUntil(
        routeName,
            (route) => false,
        arguments: arguments,
      );
    }

    /// Push named to route
    return currentState.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  void goBack(arguments) {
    final currentState = navigatorKey.currentState;

    if (currentState == null) {
      return;
    }

    currentState.pop(arguments);
  }

  void popUntil({
    required String routeName,
  }) {
    final currentState = navigatorKey.currentState;

    if (currentState == null) {
      return;
    }

    final isCurrent = _isCurrent(routeName, currentState);

    if (!isCurrent) {
      currentState.popUntil((route) => route.settings.name == routeName);
    }
  }

  bool _isCurrent(String routeName, NavigatorState currentState) {
    var isCurrent = false;
    currentState.popUntil((route) {
      if (route.settings.name == routeName) {
        isCurrent = true;
      }

      return true;
    });
    return isCurrent;
  }

  bool isCurrentWithRouteName({required String routeName}) {
    final currentState = navigatorKey.currentState;

    if (currentState == null) {
      return false;
    }

    return _isCurrent(routeName, currentState);
  }
}
