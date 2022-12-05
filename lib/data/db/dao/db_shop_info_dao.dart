import 'package:sqflite/sqflite.dart';

import '../../model/db/db_shop_info.dart';
import '../db_tables.dart';
import 'db_dao_mixin.dart';

class DbShopInfoDao with DbDaoMixin {
  DbShopInfoDao({
    required this.db,
  });

  final _tableName = DbTableNames.shopInfo;
  final String _idColumn = DbShopInfoFields.id;

  @override
  final Database db;

  @override
  String get table => _tableName;

  Future<DbShopInfo?> getObjectById({
    required int id,
  }) async {
    final maps = await get(field: _idColumn, arg: id);
    return maps.map((map) => DbShopInfo.fromJson(map)).toList().first;
  }

  Future<List<DbShopInfo>> getAllObject() async {
    final maps = await getAll();
    return maps.map((map) => DbShopInfo.fromJson(map)).toList();
  }
}
