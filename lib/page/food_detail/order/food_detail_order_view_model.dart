import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import '../../../data/model/db/db_cart_info.dart';
import '../../../data/provider/cart_provider.dart';
import '../../../resource/constants.dart';
import '../../../utils/extension/date_time_extension.dart';
import 'food_detail_order_state.dart';
import 'model/food_detail_order_arguments.dart';

class FoodDetailOrderViewModel extends StateNotifier<FoodDetailOrderState> {
  FoodDetailOrderViewModel({
    required this.reader,
  }) : super(FoodDetailOrderState.initial());

  Ref reader;

  void init(FoodDetailOrderArguments arguments) {
    state = state.copyWith(
      food: arguments.dbFoodInfo,
    );
  }

  void changeQuantity(bool isMinus) {
    final quantity = state.quantity;
    if (isMinus) {
      if (quantity > 1) {
        state = state.copyWith(
          quantity: quantity - 1,
        );
      }
    } else {
      state = state.copyWith(
        quantity: quantity + 1,
      );
    }
  }

  Future<void> addToCart() async {
    state = state.copyWith(
      formStatus: FormzStatus.submissionInProgress,
    );
    final currentTime = DateTime.now();
    final dbCartInfo = DbCartInfo(
      foodInfoId: state.food.id ?? 1,
      quantity: state.quantity,
      price: state.food.price,
      time: currentTime.dateString(Constants.fullDateFormat),
    );

    await reader.read(cartProvider.notifier).addToCart(dbCartInfo);

    state = state.copyWith(
      formStatus: FormzStatus.submissionSuccess,
    );
  }
}
