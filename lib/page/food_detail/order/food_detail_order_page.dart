import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import '../../../common_widgets/base/base_page.dart';
import '../../../common_widgets/control/large_button.dart';
import '../../../common_widgets/space_box.dart';
import '../../../data/model/enum/button_state.dart';
import '../../../gen/assets.gen.dart';
import '../../../resource/app_text_styles.dart';
import '../../../resource/constants.dart';
import 'food_detail_order_state.dart';
import 'food_detail_order_view_model.dart';
import 'model/food_detail_order_arguments.dart';

final _provider = StateNotifierProvider.autoDispose<FoodDetailOrderViewModel,
    FoodDetailOrderState>(
  (ref) => FoodDetailOrderViewModel(
    reader: ref,
  ),
);

class FoodDetailOrderPage extends BasePage {
  const FoodDetailOrderPage({
    required this.arguments,
    Key? key,
  }) : super(key: key);

  final FoodDetailOrderArguments arguments;

  @override
  FoodDetailOrderPageState createState() => FoodDetailOrderPageState();
}

class FoodDetailOrderPageState extends BasePageState<FoodDetailOrderPage> {
  @override
  void onInitState() {
    super.onInitState();
    Future.delayed(const Duration(seconds: 0), () {
      ref.read(_provider.notifier).init(widget.arguments);
    });
  }

  @override
  Widget body(BuildContext context) {
    ref.listen(_provider, (previous, next) {
      if (next is FoodDetailOrderState) {
        if (next.formStatus.isSubmissionSuccess) {
          Navigator.of(context).pop();
        }
      }
    });

    final quantity = ref.watch(_provider).quantity;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Constants.spaceWidth,
        horizontal: Constants.spaceWidth,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Colors.orangeAccent,
                  ),
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    'https://images.foody.vn/res/g115/1148609/prof/s100x100/foody-upload-api-foody-mobile-av-08b82729-220822131550.jpeg',
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                ),
              )
            ],
          ),
          const SpaceBox.height(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Đồ ăn vặt',
                  style: AppTextStyles.fontPoppinsRegular18.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                '12000 VND',
                style: AppTextStyles.fontPoppinsBold15.copyWith(
                  color: Colors.orangeAccent,
                ),
              )
            ],
          ),
          const SpaceBox.height(),
          Row(
            children: [
              Text(
                AppLocalizations.of(context)!.quantity,
                style: AppTextStyles.fontPoppinsRegular18.copyWith(
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              _buildCalculationSign(true),
              const SpaceBox.width(12),
              SizedBox(
                width: 40,
                child: Text(
                  quantity.toString(),
                  style: AppTextStyles.fontPoppinsBold15
                      .copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              const SpaceBox.width(12),
              _buildCalculationSign(false),
            ],
          ),
          const SpaceBox.height(15),
          LargeButton(
            title: AppLocalizations.of(context)!.addToCart,
            isLargeBorderRadius: false,
            buttonState: ref.watch(_provider).formStatus.isSubmissionInProgress
                ? ButtonState.loading
                : ButtonState.active,
            onTap: () {
              ref.read(_provider.notifier).addToCart();
            },
          )
        ],
      ),
    );
  }

  Widget _buildCalculationSign(bool isMinusSign) {
    return GestureDetector(
      onTap: () {
        ref.read(_provider.notifier).changeQuantity(isMinusSign);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isMinusSign ? Colors.white : Colors.deepOrange,
          border: Border.all(
            width: 1,
            color: isMinusSign ? Colors.black54 : Colors.deepOrange,
          ),
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Image.asset(
          isMinusSign ? Assets.images.icMinus.path : Assets.images.icPlus.path,
          height: 15,
          width: 15,
        ),
      ),
    );
  }
}
