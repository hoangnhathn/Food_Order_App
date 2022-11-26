import 'package:flutter/material.dart';

import '../../../common_widgets/space_box.dart';
import '../../../data/model/category/category_food.dart';
import '../../../resource/app_text_styles.dart';
import '../../../resource/constants.dart';
import '../../../utils/extension/int_extension.dart';

class ItemCategory extends StatelessWidget {
  const ItemCategory({
    required this.category,
    required this.onTap,
    required this.isLastItem,
    Key? key,
  }) : super(key: key);

  /// [category]
  final CategoryFood category;

  ///
  final bool isLastItem;

  /// [onTap]
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
          right: isLastItem ? Constants.spaceWidth : 8,
        ),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              category.logoPath,
              height: 60,
              width: 60,
            ),
            const SpaceBox.height(5),
            Text(
              category.title,
              style: AppTextStyles.fontPoppinsBold15.copyWith(
                color: Colors.white,
              ),
            ),
            Text(
              category.places.address(),
              style: AppTextStyles.fontPoppinsRegular14.copyWith(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
