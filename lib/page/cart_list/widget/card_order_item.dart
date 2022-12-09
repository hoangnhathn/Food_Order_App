import 'package:flutter/material.dart';

import '../../../common_widgets/space_box.dart';
import '../../../data/model/db/db_order_item_info.dart';
import '../../../resource/app_text_styles.dart';
import '../../../resource/constants.dart';
import '../../../utils/extension/int_extension.dart';
import '../../../utils/extension/string_extension.dart';

class CardOrderItem extends StatelessWidget {
  const CardOrderItem({
    required this.orderItem,
    Key? key,
  }) : super(key: key);

  final DbOrderItemInfo orderItem;

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
              orderItem.banner,
              height: 60,
              width: 60,
            ),
            const SpaceBox.width(),
            SizedBox(
              width: 30,
              child: Text(
                orderItem.quantity.formatQuantity,
                style: AppTextStyles.fontPoppinsBold15.copyWith(
                  color: Colors.black,
                ),
                textAlign: TextAlign.end,
              ),
            ),
            const SpaceBox.width(),
            Expanded(
              child: Text(
                orderItem.title,
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

  double get totalPrice => orderItem.price * orderItem.quantity;
}
