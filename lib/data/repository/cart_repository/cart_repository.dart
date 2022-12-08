import '../../../utils/extension/string_extension.dart';
import '../../db/db_tables.dart';
import '../../db/sq_lite_client.dart';
import '../../model/db/db_cart_info.dart';
import '../authentication_repository/authentication_repository.dart';
import '../repository.dart';

class CartRepository extends Repository {
  CartRepository(super.reader);

  Future<int?> getCurrentUserId() async {
    final userId = await secureStorage.read(key: keyAppUserID);
    return userId?.toInt();
  }

  Future<List<DbCartInfo>> getCartsByUser(int userInfoId) async {
    final dbCartInfoDao = await (await sqfLiteClient()).dbCartInfoDao;
    final carts = await dbCartInfoDao.getCartsByUser(userInfoId);
    return carts;
  }

  Future<void> addCart(DbCartInfo cart) async {
    final dbCartInfoDao = await (await sqfLiteClient()).dbCartInfoDao;

    final currentUserId = await getCurrentUserId();

    final cartFoods = await dbCartInfoDao.getCartsByUser(
      currentUserId ?? 0,
      foodInfoId: cart.foodInfoId,
    );

    if (cartFoods.isEmpty) {
      await dbCartInfoDao.insert(object: cart);
    } else {
      final cartAdded = cartFoods.first;
      await dbCartInfoDao.updateTwoFields(
        object: cartAdded.copyWith(
          quantity: cartAdded.quantity + cart.quantity,
        ),
        field1: DbCartInfoFields.userInfoId,
        arg1: currentUserId ?? 1,
        field2: DbCartInfoFields.foodInfoId,
        arg2: cart.foodInfoId,
      );
    }
  }
}
