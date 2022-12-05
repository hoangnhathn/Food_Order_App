import '../../db/sq_lite_client.dart';
import '../../model/db/db_food_info.dart';
import '../../model/db/db_shop_info.dart';
import '../repository.dart';

class FoodDetailTopRepository extends Repository {
  FoodDetailTopRepository(super.reader);

  Future<DbShopInfo?> getShopInfo(int id) async {
    final dbShopInfoDao = await (await sqfLiteClient()).dbShopInfoDao;
    final shopInfo = await dbShopInfoDao.getObjectById(id: id);
    return shopInfo;
  }

  Future<List<DbFoodInfo>> getFoodItemByShopInfo(int id) async{
    final dbFoodInfoDao = await (await sqfLiteClient()).dbFoodInfoDao;
    final foodItemInfo = await dbFoodInfoDao.getFoodItemByShopInfo(id: id);
    return foodItemInfo;
  }
}
