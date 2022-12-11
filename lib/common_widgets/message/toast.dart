import 'package:flutter/material.dart';

import '../../resource/app_color.dart';
import '../../resource/app_text_styles.dart';

class Toast extends StatelessWidget {
  const Toast({
    required this.message,
    this.color,
    this.backgroundColor,
    Key? key,
  }) : super(key: key);

  final String message;
  final Color? color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? context.colors.successLight,
          border: Border.all(
            width: 2,
            color: color ?? context.colors.success,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: (color ?? context.colors.success).withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.fontPoppinsRegular15.copyWith(
                color: color ?? context.colors.success,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
