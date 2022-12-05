import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/model/db/db_food_info.dart';
import '../../../data/model/db/db_shop_info.dart';

part 'food_detail_top_state.freezed.dart';

@freezed
class FoodDetailTopState with _$FoodDetailTopState {
  factory FoodDetailTopState({
    @Default(0) int id,
    @Default('') String estimateDelivery,
    DbShopInfo? shopInfo,
    List<DbFoodInfo>? popularFoods,
    List<DbFoodInfo>? filterCategoryFoods,
  }) = _FoodDetailTopState;

  const FoodDetailTopState._();
}
