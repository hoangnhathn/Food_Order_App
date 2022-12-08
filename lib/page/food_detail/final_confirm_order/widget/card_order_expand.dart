import 'package:flutter/material.dart';

import '../../../../common_widgets/space_box.dart';
import '../../../../resource/app_text_styles.dart';
import '../../../../resource/constants.dart';
import '../../../../utils/extension/int_extension.dart';
import '../../../../utils/extension/string_extension.dart';
import '../model/cart_food.dart';

class CardOrderExpand extends StatelessWidget {
  const CardOrderExpand({
    required this.cartFood,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  ///
  final CartFood cartFood;

  /// [onTap]
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Constants.spaceWidth,
        ),
        child: Row(
          children: [
            Image.network(
              cartFood.food.banner,
              height: 60,
              width: 60,
            ),
            const SpaceBox.width(),
            SizedBox(
              width: 30,
              child: Text(
                cartFood.quantity.formatQuantity,
                style: AppTextStyles.fontPoppinsBold15.copyWith(
                  color: Colors.black,
                ),
                textAlign: TextAlign.end,
              ),
            ),
            const SpaceBox.width(),
            Expanded(
              child: Text(
                cartFood.food.title,
                style: AppTextStyles.fontPoppinsRegular15.copyWith(
                  color: Colors.black,
                ),
              ),
            ),
            const SpaceBox.width(),
            Text(
              totalPrice.toInt().priceFormat.formatCurrency,
              style: AppTextStyles.fontPoppinsBold14.copyWith(
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }

  double get totalPrice => cartFood.food.price * cartFood.quantity;
}
