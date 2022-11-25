import 'package:flutter/material.dart';

class AppColor {
  const AppColor({
    required this.activeButton,
    required this.inActiveButton,
    required this.lightBlue,
    required this.disable,
    required this.border,
    required this.gradientLargeButton,
    required this.gradientActiveButton,
    required this.gradientInActiveButton,
    required this.hoverBackground,
    required this.colorBottomNavigation,
    required this.baseBackgroundColor,
  });

  /// light Blue
  final Color lightBlue;

  /// light Blue
  final Color activeButton;

  /// light Blue
  final Color inActiveButton;

  /// Disable
  final Color disable;

  /// Border
  final Color border;

  /// Hover - Background
  final Color hoverBackground;

  /// Gradient - Active Button Color
  final List<Color> gradientActiveButton;

  /// Gradient - Large Button Color
  final List<Color> gradientInActiveButton;

  /// Gradient - Large Button Color
  final List<Color> gradientLargeButton;

  /// Background Color
  final Color baseBackgroundColor;

  /// Color - Bottom Navigation Background
  final Color colorBottomNavigation;

  /// Color White
  final Color white = Colors.white;

  /// Color Black
  final Color black = Colors.black;

  /// Color Item Bottom Navigation
  /// Moon Active - D791D5
  /// Lotus Active - E7AA31
  /// Music Active - 5FA3FF
  /// Home Active - F15353
  /// Account Active - F5609D
  final Color colorItemNavigation = const Color(0x00979797);

  /// Light Theme
  static const light = AppColor(
    activeButton: Color(0xfffa4a0c),
    inActiveButton: Color(0xffa19d9d),
    lightBlue: Color.fromARGB(255, 32, 148, 246),
    disable: Color(0xFFE7E9EB),
    border: Color(0xFFE7E9EB),
    gradientLargeButton: [
      Color(0xFFe8a1fd),
      Color(0xFFe97bfc),
    ],
    gradientActiveButton: [
      Color(0xFFe8a1fd),
      Color(0xFFe97bfc),
    ],
    gradientInActiveButton: [
      Color(0xffd7d4d9),
      Color(0xffaba8ac),
    ],
    hoverBackground: Color.fromARGB(77, 255, 255, 255),
    colorBottomNavigation: Color.fromARGB(179, 10, 10, 47),
    baseBackgroundColor: Color(0xff1b1b36),
  );

  /// Dark Theme
}

extension AppColorExtension on BuildContext {
  AppColor get colors {
    return _colorFromBrightness(Theme.of(this).brightness);
  }

  AppColor _colorFromBrightness(Brightness brightness) {
    switch (brightness) {
      case Brightness.light:
        return AppColor.light;
      case Brightness.dark:
        return AppColor.light;
    }
  }
}
