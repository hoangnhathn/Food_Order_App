import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/db/db_cart_info.dart';
import '../../../data/model/db/db_food_info.dart';
import '../../../data/model/db/db_shop_info.dart';
import '../../../data/repository/food_detail_top/food_detail_top_repository.dart';
import '../../../resource/constants.dart';
import '../../../utils/extension/date_time_extension.dart';
import 'food_detail_top_state.dart';
import 'model/food_detail_top_arguments.dart';

class FoodDetailTopViewModel extends StateNotifier<FoodDetailTopState> {
  FoodDetailTopViewModel({
    required this.foodDetailTopRepository,
    required this.reader,
  }) : super(FoodDetailTopState());

  final FoodDetailTopRepository foodDetailTopRepository;

  Ref reader;

  Future<void> init(FoodDetailTopArguments arguments) async {
    final dateTime = DateTime.now();

    DbShopInfo? shopInfo;
    var popularFoodItemInfo = <DbFoodInfo>[];
    var cartItemInfo = <DbCartInfo>[];

    if (arguments.shopId == null) {
      final foodItem =
          await foodDetailTopRepository.getFoodItemById(arguments.foodId ?? 0);
      shopInfo = await foodDetailTopRepository.getShopInfo(foodItem.shopInfoId);
      popularFoodItemInfo = await foodDetailTopRepository
          .getFoodItemByShopInfo(foodItem.shopInfoId);
      cartItemInfo =
          await foodDetailTopRepository.getCartItemInfo(foodItem.shopInfoId);
    } else {
      shopInfo = await foodDetailTopRepository.getShopInfo(arguments.shopId!);

      popularFoodItemInfo = await foodDetailTopRepository
          .getFoodItemByShopInfo(arguments.shopId!);

      cartItemInfo =
          await foodDetailTopRepository.getCartItemInfo(arguments.shopId!);
    }

    final estimatedDelivery = dateTime.add(
      Duration(minutes: shopInfo?.time ?? 0),
    );

    state = state.copyWith(
      shopInfo: shopInfo,
      popularFoods: popularFoodItemInfo,
      filterCategoryFoods: popularFoodItemInfo,
      estimateDelivery: estimatedDelivery.dateString(
        Constants.dateFormatHHMM,
      ),
      carts: cartItemInfo,
    );
  }

  Future<void> refreshCart() async {
    final cartItemInfo =
        await foodDetailTopRepository.getCartItemInfo(state.shopInfo?.id ?? 1);

    state = state.copyWith(
      carts: cartItemInfo,
    );
  }

  int getShopInfoId() {
    return state.shopInfo?.id ?? 0;
  }
}
