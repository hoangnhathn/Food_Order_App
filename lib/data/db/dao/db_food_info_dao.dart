import 'package:sqflite/sqflite.dart';

import '../../model/db/db_food_info.dart';
import '../db_tables.dart';
import 'db_dao_mixin.dart';

class DbFoodInfoDao with DbDaoMixin {
  DbFoodInfoDao({
    required this.db,
  });

  final _tableName = DbTableNames.foodInfo;
  final _idColumn = DbFoodInfoFields.id;
  final _shopInfoIdColumn = DbFoodInfoFields.shopInfoId;

  @override
  final Database db;

  @override
  String get table => _tableName;

  Future<List<DbFoodInfo>> getFoodItemByShopInfo({
    required int id,
  }) async {
    final maps = await get(field: _shopInfoIdColumn, arg: id);
    return maps.map((map) => DbFoodInfo.fromJson(map)).toList();
  }

  Future<List<DbFoodInfo>> getAllObject() async {
    final maps = await getAll();
    return maps.map((map) => DbFoodInfo.fromJson(map)).toList();
  }
}
