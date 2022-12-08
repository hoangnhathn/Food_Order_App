import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/model/db/db_cart_info.dart';
import '../../../data/model/db/db_food_info.dart';
import 'model/cart_food.dart';

part 'final_confirm_order_state.freezed.dart';

@freezed
class FinalConfirmOrderState with _$FinalConfirmOrderState {
  factory FinalConfirmOrderState({
    @Default([]) List<DbCartInfo> carts,
    @Default(0) double totalPrice,
    @Default([]) List<DbFoodInfo> extraFoods,
    @Default([]) List<CartFood> cartFoods,
    @Default(0) int shopId,
  }) = _FinalConfirmOrderState;
}
