import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../common_widgets/space_box.dart';
import '../../../data/model/db/db_food_info.dart';
import '../../../gen/assets.gen.dart';
import '../../../resource/app_size.dart';
import '../../../resource/app_text_styles.dart';
import '../../../resource/constants.dart';
import '../../../utils/extension/int_extension.dart';

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
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: food.banner,
                width: context.sizes.width * Constants.sizeMediumCard,
                placeholder: (context, url) => imageLoading(),
                errorWidget: (context, url, error) => imageLoading(),
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.images.icStar.path,
                  height: 15,
                  width: 15,
                ),
                const SpaceBox.width(3),
                Text(
                  food.favorite.toString(),
                  style: AppTextStyles.fontPoppinsRegular14.copyWith(
                    color: Colors.black26,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SpaceBox.height(3),
            Text(
              food.price.toInt().priceFormat,
              style: AppTextStyles.fontPoppinsBold15.copyWith(
                color: Colors.orangeAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageLoading() {
    return AspectRatio(
      aspectRatio: Constants.dimensionImage,
      child: Container(
        color: Colors.black12,
      ),
    );
  }

  Widget itemChip(String icon, String content) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            height: 15,
            width: 15,
          ),
          const SpaceBox.width(5),
          Text(
            content,
            style: AppTextStyles.fontPoppinsRegular14.copyWith(
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
