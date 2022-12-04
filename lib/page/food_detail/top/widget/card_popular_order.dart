import 'package:flutter/material.dart';

import '../../../../common_widgets/space_box.dart';
import '../../../../data/model/db/db_food_info.dart';
import '../../../../resource/app_color.dart';
import '../../../../resource/app_size.dart';
import '../../../../resource/app_text_styles.dart';
import '../../../../resource/constants.dart';
import '../../../../utils/extension/int_extension.dart';
import '../../../../utils/extension/string_extension.dart';

class CardPopularOrder extends StatelessWidget {
  const CardPopularOrder({
    required this.food,
    required this.onTap,
    required this.onOrderTap,
    Key? key,
  }) : super(key: key);

  ///
  final DbFoodInfo food;

  /// [onTap]
  final VoidCallback onTap;

  /// [onOrderTap]
  final VoidCallback onOrderTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,
        width: context.sizes.width * 0.75,
        margin: const EdgeInsets.only(
          right: Constants.spaceWidth,
        ),
        padding: const EdgeInsets.only(
          right: 8,
        ),
        decoration: BoxDecoration(
          color: context.colors.baseBackgroundColor,
          border: Border.all(
            width: 1,
            color: Colors.black12,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                color: context.colors.baseBackgroundColor,
              ),
              child: Stack(
                children: [
                  Image.network(
                    food.banner,
                    width: 110,
                    height: 110,
                    fit: BoxFit.fill,
                  ),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                    ),
                    child: Text(
                      '1000 Sold',
                      style: AppTextStyles.fontPoppinsRegular15,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 5,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            food.title,
                            style: AppTextStyles.fontPoppinsRegular14,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Spacer(),
                          Text(
                            food.price.toInt().priceFormat.formatCurrency,
                            style: AppTextStyles.fontPoppinsBold14.copyWith(
                              color: Colors.deepOrangeAccent,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SpaceBox.width(5),
                  GestureDetector(
                    onTap: onOrderTap,
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                        color: Colors.deepOrange,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
