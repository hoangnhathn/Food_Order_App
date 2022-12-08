import 'package:sqflite/sqflite.dart';

import '../../model/db/db_cart_info.dart';
import '../db_tables.dart';
import 'db_dao_mixin.dart';

class DbOrderInfoDao with DbDaoMixin {
  DbOrderInfoDao({
    required this.db,
  });

  final String _tableName = DbTableNames.orderInfo;
  final String _userInfoId = DbOrderInfoFields.userInfoId;
  final String _time = DbOrderInfoFields.time;
  final String _id = DbOrderInfoFields.id;

  final String _userInfoTableName = DbTableNames.userInfo;
  final String _userIdColumn = DbUserInfoFields.id;
  final String _shopIdInfoColumn = DbFoodInfoFields.shopInfoId;

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

  // Future<List<DbCartInfo>> getCartsByUserAndShop({
  //   required int userInfoId,
  //   required int shopInfoId,
  // }) async {
  //   final joinQuery =
  //       'INNER JOIN $_userInfoTableName ON $_tableName.$_userInfoId = $_userInfoTableName.$_userIdColumn';
  //
  //   final conditionQuery =
  //       "$_foodInfoId IN (SELECT $_foodIdInfoColumn FROM $_foodInfoTableName WHERE $_shopIdInfoColumn = '$shopInfoId')";
  //
  //   final select = 'SELECT * from $_tableName $joinQuery WHERE $conditionQuery';
  //
  //   final maps = await getRaw(
  //     queryString: select,
  //     args: [],
  //   );
  //   return maps.map((map) => DbCartInfo.fromJson(map)).toList();
  // }
}
