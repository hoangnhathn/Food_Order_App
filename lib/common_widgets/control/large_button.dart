import 'package:flutter/material.dart';

import '../../data/model/enum/button_state.dart';
import '../../resource/app_color.dart';
import '../../resource/app_text_styles.dart';

/// [LargeButton] is button with expanded width screen
class LargeButton extends StatelessWidget {
  const LargeButton({
    required this.title,
    required this.onTap,
    this.prefixIcon,
    this.isLargeBorderRadius = true,
    this.buttonState = ButtonState.active,
    Key? key,
  }) : super(key: key);

  /// [title]
  final String title;

  /// [onTap] handle event click of button
  final VoidCallback onTap;

  /// Asset path Icon
  final String? prefixIcon;

  /// [isLargeBorderRadius] radius border
  final bool isLargeBorderRadius;

  /// Button State
  final ButtonState buttonState;

  Color backgroundColor(BuildContext context) {
    switch (buttonState) {
      case ButtonState.active:
        return context.colors.activeButton;
      case ButtonState.inactive:
        return context.colors.inActiveButton;
      case ButtonState.loading:
        return context.colors.activeButton;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      /// onTap => Test
      onTap: buttonState == ButtonState.active ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 12,
        ),
        decoration: BoxDecoration(
          color: backgroundColor(context),
          borderRadius: BorderRadius.circular(
            isLargeBorderRadius ? 25 : 12,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (buttonState == ButtonState.loading) ...[
              const SizedBox(
                width: 24,
                height: 24,
              ),
              const Spacer(),
            ],
            if (prefixIcon != null)
              Image.asset(
                prefixIcon!,
                height: 20,
                width: 20,
              ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.fontPoppinsBold15.copyWith(
                color: Colors.white,
              ),
            ),
            if (buttonState == ButtonState.loading) ...[
              const Spacer(),
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  color: Colors.white,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
