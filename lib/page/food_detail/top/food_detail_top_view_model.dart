import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../dummy/food.dart';
import '../../../resource/constants.dart';
import '../../../utils/extension/date_time_extension.dart';
import 'food_detail_top_state.dart';
import 'model/food_detail_top_arguments.dart';

class FoodDetailTopViewModel extends StateNotifier<FoodDetailTopState> {
  FoodDetailTopViewModel() : super(FoodDetailTopState.initial());

  void init(FoodDetailTopArguments arguments) {
    final dateTime = DateTime.now();
    final estimatedDelivery = dateTime.add(const Duration(minutes: 12));

    state = state.copyWith(
      estimateDelivery: estimatedDelivery.dateString(
        Constants.dateFormatHHMM,
      ),
      popularFoods: dummyPopularFoods,
      filterCategoryFoods: dummyPopularFoods,
    );
  }
}
