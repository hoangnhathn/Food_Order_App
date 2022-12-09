import 'package:flutter/material.dart';

import '../../../../common_widgets/space_box.dart';
import '../../../../data/model/db/db_food_info.dart';
import '../../../../resource/app_text_styles.dart';
import '../../../../resource/constants.dart';
import '../../../../utils/extension/int_extension.dart';
import '../../../../utils/extension/string_extension.dart';

class CardLargeOrder extends StatelessWidget {
  const CardLargeOrder({
    required this.onTap,
    required this.food,
    this.onOrderTap,
    this.isEnableAdd = true,
    Key? key,
  }) : super(key: key);

  /// [food]
  final DbFoodInfo food;

  /// [onTap]
  final VoidCallback onTap;

  /// [onOrderTap]
  final VoidCallback? onOrderTap;

  /// [isEnableAdd]
  final bool isEnableAdd;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,
        margin: const EdgeInsets.symmetric(
          horizontal: Constants.spaceWidth,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                food.banner,
                height: 110,
                fit: BoxFit.fill,
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
                  if (isEnableAdd)
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
