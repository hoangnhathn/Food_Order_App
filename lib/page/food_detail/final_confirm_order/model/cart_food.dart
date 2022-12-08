import '../../../../data/model/db/db_food_info.dart';

class CartFood {
  CartFood({
    required this.quantity,
    required this.food,
  });

  final int quantity;
  final DbFoodInfo food;
}
