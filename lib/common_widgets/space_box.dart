import 'package:flutter/material.dart';

/// [SpaceBox] is a widget which is same as SizedBox with space box
class SpaceBox extends SizedBox {
  const SpaceBox({
    double width = 8.0,
    double height = 8.0,
    Key? key,
  }) : super(key: key, width: width, height: height);

  const SpaceBox.width([
    double value = 8.0,
    Key? key,
  ]) : super(width: value, key: key);

  const SpaceBox.height([
    double value = 8.0,
    Key? key,
  ]) : super(height: value, key: key);
}
