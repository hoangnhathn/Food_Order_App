import '../../db/sq_lite_client.dart';
import '../../model/db/db_cart_info.dart';
import '../repository.dart';

class CartRepository extends Repository {
  CartRepository(super.reader);

  Future<List<DbCartInfo>> getCartsByUser(int userInfoId) async {
    final dbCartInfoDao = await (await sqfLiteClient()).dbCartInfoDao;
    final carts = await dbCartInfoDao.getCartsByUser(userInfoId);
    return carts;
  }

  Future<int> addCart(DbCartInfo cart) async {
    final dbCartInfoDao = await (await sqfLiteClient()).dbCartInfoDao;
    return dbCartInfoDao.insert(object: cart);
  }
}
