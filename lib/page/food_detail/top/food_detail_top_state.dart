import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/model/db/db_food_info.dart';
import '../../../dummy/food.dart';

part 'food_detail_top_state.freezed.dart';

@freezed
class FoodDetailTopState with _$FoodDetailTopState {
  factory FoodDetailTopState({
    required int id,
    required String estimateDelivery,
    required DbFoodInfo food,
    required List<DbFoodInfo> popularFoods,
    required List<DbFoodInfo> filterCategoryFoods,
  }) = _FoodDetailTopState;

  factory FoodDetailTopState.initial() => FoodDetailTopState(
        id: 0,
        estimateDelivery: '',
        food: dummyPopularFoods[0],
        popularFoods: [],
        filterCategoryFoods: [],
      );
}
