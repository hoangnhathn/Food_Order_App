import '../../page/food_detail/final_confirm_order/model/cart_food.dart';

extension CartFoodExtension on CartFood {
  double get totalPrice => quantity * food.price;
}
