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
  final String _foodInfoTableName = DbTableNames.foodInfo;
  final String _userIdColumn = DbUserInfoFields.id;
  final String _foodIdInfoColumn = DbFoodInfoFields.id;
  final String _shopIdInfoColumn = DbFoodInfoFields.shopInfoId;

  @override
  final Database db;

  @override
  String get table => _tableName;

  Future<List<DbCartInfo>> getCartsByUser(
    int userInfoId, {
    int? foodInfoId,
  }) async {
    var conditionQuery = "WHERE $_userInfoId = '$userInfoId'";
    if (foodInfoId != null) {
      conditionQuery += " AND $_foodInfoId = '$foodInfoId'";
    }

    final select = 'SELECT * from $_tableName $conditionQuery';

    final maps = await getRaw(
      queryString: select,
      args: [],
    );
    return maps.map((map) => DbCartInfo.fromJson(map)).toList();
  }

  Future<List<DbCartInfo>> getCartsByUserAndShop({
    required int userInfoId,
    required int shopInfoId,
  }) async {
    final conditionQuery =
        "$_tableName.$_userInfoId = $userInfoId AND $_foodInfoId IN (SELECT $_foodIdInfoColumn FROM $_foodInfoTableName WHERE $_shopIdInfoColumn = '$shopInfoId')";

    final select = 'SELECT * from $_tableName WHERE $conditionQuery';

    final maps = await getRaw(
      queryString: select,
      args: [],
    );
    return maps.map((map) => DbCartInfo.fromJson(map)).toList();
  }

  Future<void> deleteAllCartsByShop({
    required int userInfoId,
    required int shopInfoId,
  }) {
    final query =
        "DELETE FROM $table WHERE $_userInfoId = '$userInfoId' AND $_foodInfoId IN (SELECT $_foodIdInfoColumn FROM $_foodInfoTableName WHERE $_shopIdInfoColumn = '$shopInfoId')";
    return rawDelete(queryString: query);
  }
}
