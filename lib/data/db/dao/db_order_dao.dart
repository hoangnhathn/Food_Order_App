// import 'package:sqflite/sqflite.dart';
//
// import '../db_tables.dart';
// import 'db_dao_mixin.dart';
//
// class DbLoginInfoDao with DbDaoMixin {
//   DbLoginInfoDao({
//     required this.db,
//   });
//
//   final String _tableName = DbTableNames.loginInfo;
//
//   @override
//   final Database db;
//
//   @override
//   String get table => _tableName;
//
//   Future<DbLoginInfo?> getLoginInfoById({
//     required int id,
//   }) async {
//     final maps = await get(field: _idColumn, arg: id);
//     return maps.map((map) => DbLoginInfo.fromJson(map)).toList().first;
//   }
//
//   Future<DbLoginInfo?> getCurrentLoginInfo() async {
//     final allLoginInfo = await getAllLoginInfo();
//     return allLoginInfo.isEmpty ? null : allLoginInfo.first;
//   }
//
//   Future<List<DbLoginInfo>> getAllLoginInfo() async {
//     final maps = await getAll();
//     return maps.map((map) => DbLoginInfo.fromJson(map)).toList();
//   }
//
//   Future<int> updateLoginInfo(DbLoginInfo loginInfo) async {
//     return update(
//       object: loginInfo,
//       field: _idColumn,
//       arg: loginInfo.id,
//     );
//   }
//
//   Future<int> deleteLoginInfoById({
//     required int id,
//   }) async {
//     return delete(
//       field: _idColumn,
//       arg: id,
//     );
//   }
// }
