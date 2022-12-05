import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final estimatedDelivery = dateTime.add(const Duration(minutes: 12));

    final shopInfo =
        await foodDetailTopRepository.getShopInfo(arguments.shopId!);
    final foodItemInfo =
        await foodDetailTopRepository.getFoodItemByShopInfo(arguments.shopId!);

    state = state.copyWith(
      shopInfo: shopInfo,
      popularFoods: foodItemInfo,
      filterCategoryFoods: foodItemInfo,
      estimateDelivery: estimatedDelivery.dateString(
        Constants.dateFormatHHMM,
      ),
    );
  }
}
