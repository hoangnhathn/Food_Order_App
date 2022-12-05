import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../common_widgets/space_box.dart';
import '../../../data/model/db/db_shop_info.dart';
import '../../../gen/assets.gen.dart';
import '../../../resource/app_size.dart';
import '../../../resource/app_text_styles.dart';
import '../../../resource/constants.dart';
import '../../../utils/extension/int_extension.dart';

/// [LargeCard] is widget
class LargeCard extends StatelessWidget {
  const LargeCard({
    required this.shop,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  /// [food]
  final DbShopInfo shop;

  /// [onTap]
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
          right: Constants.spaceWidth,
        ),
        width: context.sizes.width * Constants.sizeLargeCard,
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: shop.banner,
                fit: BoxFit.fitWidth,
                placeholder: (context, url) => imageLoading(),
                errorWidget: (context, url, error) => imageLoading(),
              ),
            ),
            Text(
              shop.name,
              style: AppTextStyles.fontPoppinsBold18.copyWith(
                color: Colors.black,
              ),
            ),
            Text(
              shop.title,
              style: AppTextStyles.fontPoppinsRegular15.copyWith(
                color: Colors.black45,
              ),
            ),
            const SpaceBox.height(),
            Row(
              children: [
                const Spacer(),
                itemChip(
                  Assets.images.icLocationRed.path,
                  shop.distance.distanceStr,
                ),
                const SpaceBox.width(),
                itemChip(
                  Assets.images.icTimeRed.path,
                  shop.time.timeStr,
                ),
              ],
            )
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
