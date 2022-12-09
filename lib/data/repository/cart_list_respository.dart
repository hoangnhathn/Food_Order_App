import '../../../utils/extension/string_extension.dart';
import '../db/sq_lite_client.dart';
import '../model/db/db_cart_info.dart';
import '../model/db/db_food_info.dart';
import '../model/db/db_order_item_info.dart';
import 'authentication_repository/authentication_repository.dart';
import 'repository.dart';

class CartListRepository extends Repository {
  CartListRepository(super.reader);

  Future<int?> getCurrentUserId() async {
    final userId = await secureStorage.read(key: keyAppUserID);
    return userId?.toInt();
  }

  Future<List<DbCartInfo>> getCartsByUser() async {
    final currentUserId = await getCurrentUserId();
    final dbCartInfoDao = await (await sqfLiteClient()).dbCartInfoDao;
    final carts = await dbCartInfoDao.getCartsByUser(currentUserId ?? 0);
    return carts;
  }

  Future<List<DbOrderItemInfo>> getOrdersByUser() async {
    final currentUserId = await getCurrentUserId();
    final dbOrderItemInfoDao = await (await sqfLiteClient()).dbOrderItemInfoDao;
    final orders =
        await dbOrderItemInfoDao.getOrderItemsByUser(currentUserId ?? 0);
    return orders;
  }

  Future<List<DbFoodInfo>> getAllFoodItemInfo() async {
    final dbFoodInfoDao = await (await sqfLiteClient()).dbFoodInfoDao;
    final foodItemInfo = await dbFoodInfoDao.getAll();
    return foodItemInfo.map((e) => DbFoodInfo.fromJson(e)).toList();
  }
}
