import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/model/db/db_food_info.dart';
import '../../data/model/db/db_shop_info.dart';
import 'model/search_condition_type.dart';

part 'search_list_state.freezed.dart';

@freezed
class SearchListState with _$SearchListState {
  factory SearchListState({
    @Default(SearchConditionType.viewByCategory)
        SearchConditionType searchConditionType,
    @Default([]) List<DbFoodInfo> foods,
    @Default([]) List<DbShopInfo> shops,
    @Default([]) List<DbFoodInfo> originalFoods,
    @Default([]) List<DbShopInfo> originalShops,
    @Default(0) int index,
  }) = _SearchListState;
}
