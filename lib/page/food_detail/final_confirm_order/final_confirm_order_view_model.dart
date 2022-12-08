import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/db/db_cart_info.dart';
import '../../../data/model/db/db_food_info.dart';
import '../../../data/provider/loading_state_provider.dart';
import '../../../data/repository/final_confirm_order/final_confirm_order_repository.dart';
import '../../../utils/extension/cart_food_extension.dart';
import 'final_confirm_order_state.dart';
import 'model/cart_food.dart';
import 'model/final_confirm_order_arguments.dart';

class FinalConfirmOrderViewModel extends StateNotifier<FinalConfirmOrderState> {
  FinalConfirmOrderViewModel({
    required this.finalConfirmOrderRepository,
    required this.reader,
  }) : super(FinalConfirmOrderState());

  final FinalConfirmOrderRepository finalConfirmOrderRepository;

  Ref reader;

  Future<void> init(FinalConfirmOrderArguments arguments) async {
    final shopId = arguments.shopId;
    final carts =
        await finalConfirmOrderRepository.getAllCartByShopAndUser(shopId);

    final extraFoods =
        await finalConfirmOrderRepository.getFoodItemInfo(shopId);

    state = state.copyWith(
      shopId: shopId,
      carts: carts,
      extraFoods: extraFoods,
      cartFoods: mapToCartFood(carts, extraFoods),
    );

    calculateTotalPrice();
  }

  double calculateTotalPrice() {
    final carts = [...state.cartFoods];
    double totalPrice = 0;
    for (final cart in carts) {
      totalPrice += cart.totalPrice;
    }

    return totalPrice;
  }

  Future<void> submitOrder() async {
    reader.read(loadingStateProvider).toLoading(isShowLoadingDialog: true);
    await finalConfirmOrderRepository.submitOrder(state.shopId);
    await Future.delayed(const Duration(seconds: 1));
    reader.read(loadingStateProvider).toIdle();
  }

  List<CartFood> mapToCartFood(List<DbCartInfo> carts, List<DbFoodInfo> foods) {
    final cartFood = <CartFood>[];
    for (final cart in carts) {
      final food = foods
          .where((element) => element.id == cart.foodInfoId)
          .toList()
          .first;
      cartFood.add(
        CartFood(
          quantity: cart.quantity,
          food: food,
        ),
      );
    }
    return cartFood;
  }

  Future<void> refreshScreen() async {
    final carts =
        await finalConfirmOrderRepository.getAllCartByShopAndUser(state.shopId);

    final cartFoods = mapToCartFood(carts, state.extraFoods);

    state = state.copyWith(
      carts: carts,
      cartFoods: cartFoods,
    );
  }
}
