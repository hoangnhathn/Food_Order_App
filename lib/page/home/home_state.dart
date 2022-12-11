import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/model/category/category_food.dart';
import '../../data/model/db/db_food_info.dart';
import '../../data/model/db/db_shop_info.dart';
import '../../data/model/db/db_user_info.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    required DbUserInfo userInfo,
    required List<CategoryFood> categories,
    required List<String> banners,
    required List<DbFoodInfo> recommends,
    required List<DbShopInfo> populars,
    @Default(0) int index,
  }) = _HomeState;

  factory HomeState.initial() => HomeState(
        userInfo: DbUserInfo(
          name: '',
          username: '',
          password: '',
        ),
        categories: [],
        banners: [],
        populars: [],
        recommends: [],
        index: 0,
      );
}
