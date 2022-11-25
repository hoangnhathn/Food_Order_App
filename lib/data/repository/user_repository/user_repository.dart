import '../../../utils/extension/string_extension.dart';
import '../../db/sq_lite_client.dart';
import '../../model/db/db_user_info.dart';
import '../authentication_repository/authentication_repository.dart';
import '../repository.dart';

class UserRepository extends Repository {
  UserRepository(super.reader);

  Future<int> createUser({
    required DbUserInfo userInfo,
  }) async {
    final dbUserInfoDao = await (await sqfLiteClient()).dbUserInfoDao;
    return dbUserInfoDao.insert(object: userInfo);
  }

  Future<DbUserInfo?> getCurrentUser() async {
    final dbUserInfoDao = await (await sqfLiteClient()).dbUserInfoDao;
    final currentUserId = await secureStorage.read(key: keyAppUserID);
    return dbUserInfoDao.getUserById(currentUserId!.toInt());
  }
}
