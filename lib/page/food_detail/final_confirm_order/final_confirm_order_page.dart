import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/app_bar/default_app_bar.dart';
import '../../../common_widgets/base/base_page.dart';
import '../../../common_widgets/control/large_button.dart';
import '../../../common_widgets/space_box.dart';
import '../../../data/model/db/db_food_info.dart';
import '../../../data/provider/modal_bottom_sheet_provider.dart';
import '../../../data/provider/toast_provider.dart';
import '../../../data/repository/final_confirm_order/final_confirm_order_repository.dart';
import '../../../gen/assets.gen.dart';
import '../../../resource/app_color.dart';
import '../../../resource/app_text_styles.dart';
import '../../../resource/constants.dart';
import '../../../utils/extension/int_extension.dart';
import '../../../utils/extension/string_extension.dart';
import '../order/food_detail_order_page.dart';
import '../order/model/food_detail_order_arguments.dart';
import '../widget/card_popular_order.dart';
import 'final_confirm_order_state.dart';
import 'final_confirm_order_view_model.dart';
import 'model/cart_food.dart';
import 'model/final_confirm_order_arguments.dart';
import 'widget/card_order_expand.dart';

final _provider =
    StateNotifierProvider<FinalConfirmOrderViewModel, FinalConfirmOrderState>(
  (ref) => FinalConfirmOrderViewModel(
    finalConfirmOrderRepository: FinalConfirmOrderRepository(ref),
    reader: ref,
  ),
);

class FinalConfirmOrderPage extends BasePage {
  const FinalConfirmOrderPage({
    required this.arguments,
    Key? key,
  }) : super(key: key);

  final FinalConfirmOrderArguments arguments;

  @override
  FinalConfirmOrderPageState createState() => FinalConfirmOrderPageState();
}

class FinalConfirmOrderPageState extends BasePageState<FinalConfirmOrderPage> {
  @override
  void onInitState() {
    super.onInitState();

    Future.delayed(const Duration(seconds: 0), () {
      ref.read(_provider.notifier).init(widget.arguments);
    });
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) => DefaultAppBar(
        title: AppLocalizations.of(context)!.confirmOrder,
        onLeftTapped: () {
          Navigator.of(context).pop();
        },
      );

  @override
  Color get backgroundColor => context.colors.baseBackgroundColor;

  @override
  Widget body(BuildContext context) {
    final cartFoods = ref.watch(_provider).cartFoods;
    final extraFoods = ref.watch(_provider).extraFoods;
    final totalPrice = ref.read(_provider.notifier).calculateTotalPrice();

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SpaceBox.height(),
                _buildAddressInfo(),
                const SpaceBox.height(),
                if (cartFoods.isNotEmpty) _buildCarts(cartFoods),
                const SpaceBox.height(),
                Padding(
                  padding: const EdgeInsets.only(
                    left: Constants.spaceWidth,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.orderExtraFoods,
                    style: AppTextStyles.fontOverpassBold15.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
                const SpaceBox.height(),
                _buildExtraFood(extraFoods),
              ],
            ),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Constants.spaceWidth,
                horizontal: Constants.spaceWidth,
              ),
              child: LargeButton(
                isBoldText: false,
                isLargeBorderRadius: false,
                title: AppLocalizations.of(context)!.placeOrder(
                  totalPrice.toInt().priceFormat.formatCurrency,
                ),
                onTap: () {
                  submitOrder();
                },
              ),
            ),
            const SpaceBox.height(),
          ],
        ),
      ],
    );
  }

  Widget _buildAddressInfo() {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 5,
            ),
            child: Image.asset(
              Assets.images.icAddress.path,
              height: 15,
              width: 15,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.shippingAddress,
                        style: AppTextStyles.fontPoppinsRegular14.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Test | 1234',
                        style: AppTextStyles.fontPoppinsRegular14.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Address',
                        style: AppTextStyles.fontPoppinsRegular14.copyWith(
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExtraFood(List<DbFoodInfo> extraFoods) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SpaceBox.width(
            Constants.spaceWidth,
          ),
          ...extraFoods.map((food) {
            return CardPopularOrder(
              onTap: () {},
              onOrderTap: () async {
                await _navigateToFoodOrderPage(food);
              },
              food: food,
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCarts(List<CartFood> cartFoods) {
    return ListView.builder(
      itemCount: cartFoods.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final cartFood = cartFoods[index];
        return CardOrderExpand(
          cartFood: cartFood,
          onTap: () {},
        );
      },
    );
  }

  Future<void> _navigateToFoodOrderPage(DbFoodInfo food) async {
    await ref.read(modalBottomSheetProvider).showModal(
      builder: (context) {
        return FoodDetailOrderPage(
          arguments: FoodDetailOrderArguments(
            dbFoodInfo: food,
          ),
        );
      },
    );

    await ref.read(_provider.notifier).refreshScreen();
  }

  Future<void> submitOrder() async {
    await ref.read(_provider.notifier).submitOrder();
    ref.read(toastProvider).showToast(
          context: context,
          message: AppLocalizations.of(context)!.orderSuccessMessage,
        );
    Navigator.of(context).pop();
  }
}
