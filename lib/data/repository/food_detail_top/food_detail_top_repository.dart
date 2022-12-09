import '../../../utils/extension/string_extension.dart';
import '../../db/sq_lite_client.dart';
import '../../model/db/db_cart_info.dart';
import '../../model/db/db_food_info.dart';
import '../../model/db/db_shop_info.dart';
import '../authentication_repository/authentication_repository.dart';
import '../repository.dart';

class FoodDetailTopRepository extends Repository {
  FoodDetailTopRepository(super.reader);

  Future<int?> getCurrentUserId() async {
    final userId = await secureStorage.read(key: keyAppUserID);
    return userId?.toInt();
  }

  Future<DbShopInfo?> getShopInfo(int id) async {
    final dbShopInfoDao = await (await sqfLiteClient()).dbShopInfoDao;
    final shopInfo = await dbShopInfoDao.getObjectById(id: id);
    return shopInfo;
  }

  Future<List<DbFoodInfo>> getFoodItemByShopInfo(int id) async {
    final dbFoodInfoDao = await (await sqfLiteClient()).dbFoodInfoDao;
    final foodItemInfo = await dbFoodInfoDao.getFoodItemByShopInfo(id: id);
    return foodItemInfo;
  }

  Future<List<DbCartInfo>> getCartItemInfo(int shopInfoId) async {
    final currentUserId = await getCurrentUserId();
    final dbCartInfoDao = await (await sqfLiteClient()).dbCartInfoDao;
    final cartItemInfo = await dbCartInfoDao.getCartsByUserAndShop(
      userInfoId: currentUserId ?? 1,
      shopInfoId: shopInfoId,
    );
    return cartItemInfo;
  }

  Future<DbFoodInfo> getFoodItemById(int id) async {
    final dbFoodInfoDao = await (await sqfLiteClient()).dbFoodInfoDao;
    final foodItemInfo = await dbFoodInfoDao.getFoodItemById(id: id);
    return foodItemInfo;
  }
}
