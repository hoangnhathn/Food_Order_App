import '../../data/model/db/db_cart_info.dart';

extension DbCartInfoExtension on DbCartInfo {
  double get totalPrice => price * quantity;
}
