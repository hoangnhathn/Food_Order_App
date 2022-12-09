import '../../db/sq_lite_client.dart';
import '../../model/db/db_food_info.dart';
import '../../model/db/db_shop_info.dart';
import '../repository.dart';

class HomeRepository extends Repository {
  HomeRepository(super.reader);

  Future<List<DbShopInfo>> getAllShopItems() async {
    final dbShopInfoDao = await (await sqfLiteClient()).dbShopInfoDao;
    final dbShopItemInfo = await dbShopInfoDao.getAllObject();
    return dbShopItemInfo;
  }

  Future<List<DbFoodInfo>> getAllFoodItems() async {
    final dbFoodInfoDao = await (await sqfLiteClient()).dbFoodInfoDao;
    final dbFoodItemInfo = await dbFoodInfoDao.getAllObject(
      limit: 10,
    );
    return dbFoodItemInfo;
  }
}
