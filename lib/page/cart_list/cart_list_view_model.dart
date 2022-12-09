import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/db/db_cart_info.dart';
import '../../data/model/db/db_food_info.dart';
import '../../data/repository/cart_list/cart_list_respository.dart';
import '../food_detail/final_confirm_order/model/cart_food.dart';
import 'cart_list_state.dart';

class CartListViewModel extends StateNotifier<CartListState> {
  CartListViewModel({
    required this.cartListRepository,
    required this.reader,
  }) : super(CartListState());

  final CartListRepository cartListRepository;

  Ref reader;

  Future<void> init() async {
    final carts = await cartListRepository.getCartsByUser();

    final foods = await cartListRepository.getAllFoodItemInfo();

    final orderItems = await cartListRepository.getOrdersByUser();

    state = state.copyWith(
      orderItems: orderItems,
      cartFoods: mapToCartFood(carts, foods),
    );
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

  void changeIndex(int index) {
    state = state.copyWith(
      indexSelected: index,
    );
  }
}
