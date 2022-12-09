import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/model/db/db_order_item_info.dart';
import '../food_detail/final_confirm_order/model/cart_food.dart';

part 'cart_list_state.freezed.dart';

@freezed
class CartListState with _$CartListState {
  factory CartListState({
    @Default([]) List<DbOrderItemInfo> orderItems,
    @Default([]) List<CartFood> cartFoods,
    @Default(0) int indexSelected,
  }) = _CartListState;
}
