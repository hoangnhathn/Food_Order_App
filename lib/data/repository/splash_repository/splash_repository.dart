import '../../../dummy/food.dart';
import '../../../dummy/shop.dart';
import '../../db/sq_lite_client.dart';
import '../repository.dart';

const keyFirstOpenApp = 'key_first_open_app';

class SplashRepository extends Repository {
  SplashRepository(super.reader);

  /// Check open app for the first time
  Future<bool> isFirstOpenApp() async {
    final firstOpenApp = await secureStorage.read(key: keyFirstOpenApp);
    if (firstOpenApp == null) {
      await secureStorage.write(key: keyFirstOpenApp, value: true.toString());

      /// insert dummy data
      await insertDummyData();
      return true;
    }
    return false;
  }

  /// Insert dummy data when user open app for the first time
  Future<void> insertDummyData() async {
    final dbFoodInfoDao = await (await sqfLiteClient()).dbFoodInfoDao;
    final dbShopInfoDao = await (await sqfLiteClient()).dbShopInfoDao;

    /// Insert Dummy Shop Info to DB Shop Info First
    await dbShopInfoDao.insertAll(objects: dummyShops);

    /// Insert Dummy Food Info to DB Food Info
    await dbFoodInfoDao.insertAll(objects: dummyFoods);
  }
}
