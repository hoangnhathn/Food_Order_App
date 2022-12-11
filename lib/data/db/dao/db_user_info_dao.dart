import 'package:sqflite/sqflite.dart';

import '../../model/db/db_user_info.dart';
import '../db_tables.dart';
import 'db_dao_mixin.dart';

class DbUserInfoDao with DbDaoMixin {
  DbUserInfoDao({
    required this.db,
  });

  final String _tableName = DbTableNames.userInfo;
  final String _name = DbUserInfoFields.name;
  final String _username = DbUserInfoFields.username;
  final String _password = DbUserInfoFields.password;
  final String _id = DbUserInfoFields.id;

  @override
  final Database db;

  @override
  String get table => _tableName;

  Future<DbUserInfo?> loginManual({
    required String username,
    required String password,
  }) async {
    final maps = await getMultipleField(
      columns: [_username, _password],
      args: [username, password],
    );
    if (maps.isNotEmpty) {
      return DbUserInfo.fromJson(maps.first);
    }
    return null;
  }

  Future<DbUserInfo?> getUserById(int id) async {
    final map = await get(field: _id, arg: id);
    if (map.isNotEmpty) {
      return DbUserInfo.fromJson(map.first);
    }
    return null;
  }

  Future<void> updateName(
    int id,
    String name,
  ) async {
    final queryUpdate =
        'UPDATE $_tableName SET ${DbUserInfoFields.name} = ? WHERE ${DbUserInfoFields.id} = ?';
    await rawUpdate(
      query: queryUpdate,
      arguments: [name, id],
    );
  }
}
