import 'package:flutter/material.dart';

import '../../../common_widgets/space_box.dart';
import '../../../data/model/db/db_food_info.dart';
import '../../../resource/app_size.dart';
import '../../../resource/app_text_styles.dart';
import '../../../resource/constants.dart';

class MediumCard extends StatelessWidget {
  const MediumCard({
    required this.onTap,
    required this.food,
    required this.isLastItem,
    Key? key,
  }) : super(key: key);

  /// [onTap]
  final VoidCallback onTap;

  /// [food]
  final DbFoodInfo food;

  /// [isLastItem]
  final bool isLastItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: context.sizes.width * Constants.sizeMediumCard,
        margin: EdgeInsets.only(
          right: isLastItem ? Constants.spaceWidth : 8,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                food.banner,
                fit: BoxFit.fitWidth,
              ),
            ),
            Text(
              food.title,
              style: AppTextStyles.fontPoppinsBold15.copyWith(
                color: Colors.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SpaceBox.height(3),
            Text(
              food.subTitle,
              style: AppTextStyles.fontPoppinsRegular14.copyWith(
                color: Colors.black26,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
