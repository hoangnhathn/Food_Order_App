import 'package:flutter/widgets.dart';

import '../../../resource/app_size.dart';
import '../../../resource/constants.dart';

class CardBanner extends StatelessWidget {
  const CardBanner({
    required this.onTap,
    required this.image,
    required this.isLastItem,
    Key? key,
  }) : super(key: key);

  /// [onTap]
  final VoidCallback onTap;

  /// [image]
  final String image;

  /// [isLastItem]
  final bool isLastItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
          right: isLastItem ? Constants.spaceWidth : 8,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                image,
                width: context.sizes.width * 0.8,
              ),
            )
          ],
        ),
      ),
    );
  }
}
