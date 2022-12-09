import '../../db/sq_lite_client.dart';
import '../../model/db/db_food_info.dart';
import '../../model/db/db_shop_info.dart';
import '../repository.dart';

class SearchListRepository extends Repository {
  SearchListRepository(super.reader);

  Future<List<DbFoodInfo>> getAllDbFoodInfo() async {
    final dbFoodInfoDao = await (await sqfLiteClient()).dbFoodInfoDao;
    final foodItems = await dbFoodInfoDao.getAllObject();
    return foodItems;
  }

  Future<List<DbShopInfo>> getAllDbShopInfo() async {
    final dbShopInfoDao = await (await sqfLiteClient()).dbShopInfoDao;
    final shopItems = await dbShopInfoDao.getAllObject();
    return shopItems;
  }


  Future<List<DbFoodInfo>> getFoodByCategory(int categoryId) async {
    final dbFoodInfoDao = await (await sqfLiteClient()).dbFoodInfoDao;
    final foodItems = await dbFoodInfoDao.getFoodByCategory(
      categoryId: categoryId,
    );
    return foodItems;
  }

//   Future<List<DbFoodInfo>> searchFoodItem() async {
//     final dbFoodInfoDao = await (await sqfLiteClient()).dbFoodInfoDao;
//
//   }
}
