import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/model/db/db_food_info.dart';
import '../../../dummy/food.dart';

part 'food_detail_order_state.freezed.dart';

@freezed
class FoodDetailOrderState with _$FoodDetailOrderState {
  factory FoodDetailOrderState({
    required DbFoodInfo food,
    required FormzStatus formStatus,
    @Default(1) int quantity,
  }) = _FoodDetailOrderState;

  factory FoodDetailOrderState.initial() => FoodDetailOrderState(
        food: dummyPopularFoods[0],
        formStatus: FormzStatus.pure,
      );
}
