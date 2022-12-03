import 'package:flutter/material.dart';

import '../../resource/app_text_styles.dart';
import '../../resource/constants.dart';

class LineTitleTransition extends StatelessWidget {
  const LineTitleTransition({
    required this.onTap,
    required this.title,
    required this.titleTransition,
    Key? key,
  }) : super(key: key);

  /// [title]
  final String title;

  /// [titleTransition]
  final String titleTransition;

  /// [onTap] handle click more
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: Constants.spaceWidth,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.fontOpenSansBold17.copyWith(
                color: Colors.black,
              ),
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 5,
                top: 5,
                bottom: 5,
              ),
              child: Text(
                titleTransition,
                style: AppTextStyles.fontPoppinsRegular15.copyWith(
                  color: Colors.red,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
