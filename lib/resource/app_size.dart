import 'package:flutter/cupertino.dart';

class AppSize {
  const AppSize({
    required this.width,
    required this.height,
  });

  /// Height of Screen
  final double height;

  /// Width of Screen
  final double width;

  static AppSize sizeApp(BuildContext context) {
    return AppSize(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
    );
  }
}

extension AppSizeExtension on BuildContext {
  AppSize get sizes {
    return AppSize.sizeApp(this);
  }
}
