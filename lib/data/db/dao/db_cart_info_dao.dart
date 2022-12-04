import 'package:sqflite/sqflite.dart';

import '../../model/db/db_cart_info.dart';
import '../db_tables.dart';
import 'db_dao_mixin.dart';

class DbCartInfoDao with DbDaoMixin {
  DbCartInfoDao({
    required this.db,
  });

  final String _tableName = DbTableNames.cartInfo;
  final String _userInfoId = DbCartInfoFields.userInfoId;
  final String _foodInfoId = DbCartInfoFields.foodInfoId;
  final String _price = DbCartInfoFields.price;
  final String _quantity = DbCartInfoFields.quantity;
  final String _time = DbCartInfoFields.time;
  final String _id = DbUserInfoFields.id;

  final String _userInfoTableName = DbTableNames.userInfo;
  final String _userIdColumn = DbUserInfoFields.id;

  @override
  final Database db;

  @override
  String get table => _tableName;

  Future<List<DbCartInfo>> getCartsByUser(int userInfoId) async {
    final joinQuery =
        'INNER JOIN $_userInfoTableName ON $_tableName.$_userInfoId = $_userInfoTableName.$_userIdColumn';
    final select = 'SELECT * from $_tableName $joinQuery';
    final maps = await getRaw(
      queryString: select,
      args: [],
    );
    return maps.map((map) => DbCartInfo.fromJson(map)).toList();
  }
}
