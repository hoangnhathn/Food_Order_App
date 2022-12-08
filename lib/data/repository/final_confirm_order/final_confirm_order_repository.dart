import '../../../resource/constants.dart';
import '../../../utils/extension/date_time_extension.dart';
import '../../../utils/extension/string_extension.dart';
import '../../db/sq_lite_client.dart';
import '../../model/db/db_cart_info.dart';
import '../../model/db/db_food_info.dart';
import '../../model/db/db_order_info.dart';
import '../../model/db/db_order_item_info.dart';
import '../../model/db/db_shop_info.dart';
import '../authentication_repository/authentication_repository.dart';
import '../repository.dart';

class FinalConfirmOrderRepository extends Repository {
  FinalConfirmOrderRepository(super.reader);

  Future<DbShopInfo?> getShopInfo(int id) async {
    final dbShopInfoDao = await (await sqfLiteClient()).dbShopInfoDao;
    final shopInfo = await dbShopInfoDao.getObjectById(id: id);
    return shopInfo;
  }

  Future<List<DbFoodInfo>> getFoodItemInfo(int id) async {
    final dbFoodInfoDao = await (await sqfLiteClient()).dbFoodInfoDao;
    final foodItemInfo = await dbFoodInfoDao.getFoodItemByShopInfo(id: id);
    return foodItemInfo;
  }

  Future<int?> getCurrentUserId() async {
    final userId = await secureStorage.read(key: keyAppUserID);
    return userId?.toInt();
  }

  Future<List<DbCartInfo>> getAllCartByShopAndUser(int shopInfoId) async {
    final currentUserId = await getCurrentUserId();
    final dbCartInfoDao = await (await sqfLiteClient()).dbCartInfoDao;

    final carts = await dbCartInfoDao.getCartsByUserAndShop(
      userInfoId: currentUserId ?? 1,
      shopInfoId: shopInfoId,
    );

    return carts;
  }

  Future<void> submitOrder(int shopId) async {
    final currentUserId = await getCurrentUserId();
    final dbCartInfoDao = await (await sqfLiteClient()).dbCartInfoDao;
    final dbOrderInfoDao = await (await sqfLiteClient()).dbOrderInfoDao;
    final dbFoodInfoDao = await (await sqfLiteClient()).dbFoodInfoDao;
    final dbOrderItemInfoDao = await (await sqfLiteClient()).dbOrderItemInfoDao;

    /// Get All Food
    final foods = await dbFoodInfoDao.getFoodItemByShopInfo(
      id: shopId,
    );

    /// Create new order
    final orderId = await dbOrderInfoDao.insert(
      object: DbOrderInfo(
        userInfoId: currentUserId ?? 0,
        shopInfoId: shopId,
        time: DateTime.now().dateString(
          Constants.dateFormatYYYYMMDDForwardSlash,
        ),
      ),
    );

    /// Add Order Item
    final carts = await dbCartInfoDao.getCartsByUserAndShop(
      userInfoId: currentUserId ?? 0,
      shopInfoId: shopId,
    );

    for (final cart in carts) {
      final food = foods.firstWhere(
        (element) => element.id == cart.foodInfoId,
      );
      final orderItemInfo = DbOrderItemInfo(
        quantity: cart.quantity,
        foodInfoId: cart.foodInfoId,
        price: cart.price,
        orderInfoId: orderId,
        title: food.title,
        banner: food.banner,
      );
      await dbOrderItemInfoDao.insert(object: orderItemInfo);
    }

    /// Remove all cart of shop
    await dbCartInfoDao.deleteAllCartsByShop(
      userInfoId: currentUserId ?? 0,
      shopInfoId: shopId,
    );
  }
}
