import '../../../utils/extension/string_extension.dart';
import '../../db/sq_lite_client.dart';
import '../authentication_repository/authentication_repository.dart';
import '../repository.dart';

class ProfileRepository extends Repository {
  ProfileRepository(super.reader);

  Future<int?> getCurrentUserId() async {
    final userId = await secureStorage.read(key: keyAppUserID);
    return userId?.toInt();
  }

  Future<String> getName() async {
    final currentUserId = await getCurrentUserId();
    final dbUserInfoDao = await (await sqfLiteClient()).dbUserInfoDao;
    final dbUserInfo = await dbUserInfoDao.getUserById(currentUserId ?? 1);
    return dbUserInfo?.name ?? '';
  }

  Future<int> getCartCount() async {
    final currentUserId = await getCurrentUserId();
    final dbCartInfoDao = await (await sqfLiteClient()).dbCartInfoDao;
    final carts = await dbCartInfoDao.getCartsByUser(currentUserId ?? 0);
    return carts.length;
  }

  Future<int> getOrderCount() async {
    final currentUserId = await getCurrentUserId();
    final dbOrderItemInfoDao = await (await sqfLiteClient()).dbOrderItemInfoDao;

    final orderItems =
        await dbOrderItemInfoDao.getOrderItemsByUser(currentUserId ?? 0);

    return orderItems.length;
  }

  Future<void> changeName(String value) async {
    if (value.isEmpty) {
      return;
    }
    final currentUserId = await getCurrentUserId();
    final dbUserInfoDao = await (await sqfLiteClient()).dbUserInfoDao;
    await dbUserInfoDao.updateName(
      currentUserId ?? 0,
      value,
    );
  }
}
