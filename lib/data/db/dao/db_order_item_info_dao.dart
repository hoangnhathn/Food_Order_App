import 'package:sqflite/sqflite.dart';

import '../../model/db/db_order_item_info.dart';
import '../db_tables.dart';
import 'db_dao_mixin.dart';

class DbOrderItemInfoDao with DbDaoMixin {
  DbOrderItemInfoDao({
    required this.db,
  });

  final String _tableName = DbTableNames.orderItemInfo;
  final String _foodInfoId = DbOrderItemInfoFields.foodInfoId;
  final String _orderInfoId = DbOrderItemInfoFields.orderInfoId;
  final String _banner = DbOrderItemInfoFields.banner;
  final String _quantity = DbOrderItemInfoFields.quantity;
  final String _price = DbOrderItemInfoFields.price;
  final String _title = DbOrderItemInfoFields.title;
  final String _id = DbOrderItemInfoFields.id;

  final String _userInfoTableName = DbTableNames.userInfo;
  final String _foodInfoTableName = DbTableNames.foodInfo;
  final String _orderInfoTableName = DbTableNames.orderInfo;
  final String _orderInfoIdColumn = DbOrderInfoFields.id;
  final String _orderInfoUserInfoIdColumn = DbOrderInfoFields.userInfoId;
  final String _userIdColumn = DbUserInfoFields.id;
  final String _foodIdInfoColumn = DbFoodInfoFields.id;
  final String _shopIdInfoColumn = DbFoodInfoFields.shopInfoId;

  @override
  final Database db;

  @override
  String get table => _tableName;

  // Future<List<DbCartInfo>> getCartsByUser(int userInfoId) async {
  //   final joinQuery =
  //       'INNER JOIN $_userInfoTableName ON $_tableName.$_userInfoId = $_userInfoTableName.$_userIdColumn';
  //   final select = 'SELECT * from $_tableName $joinQuery';
  //   final maps = await getRaw(
  //     queryString: select,
  //     args: [],
  //   );
  //   return maps.map((map) => DbCartInfo.fromJson(map)).toList();
  // }

  Future<List<DbOrderItemInfo>> getOrderItemsByUser(int userInfoId) async {
    final joinQuery =
        "INNER JOIN $_orderInfoTableName ON $_tableName.$_orderInfoId = $_orderInfoTableName.$_orderInfoIdColumn WHERE $_orderInfoTableName.$_orderInfoUserInfoIdColumn = '$userInfoId'";
    final select = 'SELECT * from $_tableName $joinQuery';
    final maps = await getRaw(
      queryString: select,
      args: [],
    );
    return maps.map((map) => DbOrderItemInfo.fromJson(map)).toList();
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
