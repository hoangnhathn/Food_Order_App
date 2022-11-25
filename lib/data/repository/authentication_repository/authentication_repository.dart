import '../../db/sq_lite_client.dart';
import '../repository.dart';

const keyAppUserID = 'key_app_user_id';

class AuthenticationRepository extends Repository {
  AuthenticationRepository(super.reader);

  Future<bool> isAuthenticated() async {
    final userId = await secureStorage.read(key: keyAppUserID);
    if (userId != null) {
      return true;
    }
    return false;
  }

  Future<bool> loginManual(String username, String password) async {
    final userInfo = await (await (await sqfLiteClient()).dbUserInfoDao)
        .loginManual(username: username, password: password);
    if (userInfo != null) {
      /// Save Key User Id
      await secureStorage.write(
        key: keyAppUserID,
        value: userInfo.id.toString(),
      );
      return true;
    }
    return false;
  }
}
