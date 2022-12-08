import 'package:sqflite/sqflite.dart';

import '../../../resource/constants.dart';
import '../../model/db_base_model.dart';

mixin DbDaoMixin<T extends DbBaseModel> {
  Database get db;

  String get table;

  Future<int> insert({
    required DbBaseModel object,
  }) async {
    return db.insert(
      table,
      object.toJson(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  Future<void> insertAll({
    required List<DbBaseModel> objects,
  }) async {
    final batch = db.batch();
    for (final object in objects) {
      batch.insert(table, object.toJson());
    }
    await batch.commit();
  }

  Future<List<Map<String, dynamic>>> get({
    required String field,
    required arg,
    int? limit,
    String operator = '=',
  }) {
    return db.query(
      table,
      where: '$field $operator ?',
      whereArgs: [arg],
      limit: limit,
    );
  }

  Future<List<Map<String, dynamic>>> getObjectIsNotDeleted({
    required String field,
    required arg,
    int? limit,
    String operator = '=',
  }) async {
    return db.query(
      table,
      where:
          '$field, $operator ? AND (${Constants.isDeletedColumn} IS NULL or ${Constants.isDeletedColumn} = 0)',
      whereArgs: [arg],
      limit: limit,
    );
  }

  Future<List<Map<String, dynamic>>> getRaw({
    required String queryString,
    required List<Object> args,
  }) async {
    return db.rawQuery(
      queryString,
      args,
    );
  }

  Future<List<Map<String, dynamic>>> getAll({int? limit}) {
    return db.query(table, limit: limit);
  }

  Future<int> delete({
    required String field,
    required arg,
  }) async {
    return db.delete(
      table,
      where: '$field = ?',
      whereArgs: [arg],
    );
  }

  Future<void> rawDelete({
    required String queryString,
  }) async {
    await db.rawDelete(
      queryString,
    );
  }

  Future<int> deleteAll() async {
    return db.rawDelete('DELETE FROM $table');
  }

  Future<int> update({
    required DbBaseModel object,
    required String field,
    required arg,
  }) async {
    return db.update(
      table,
      object.toJson(),
      where: '$field = ?',
      whereArgs: [arg],
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  Future<int> updateTwoFields({
    required DbBaseModel object,
    required String field1,
    required String field2,
    required arg1,
    required arg2,
  }) async {
    return db.update(
      table,
      object.toJson(),
      where: '$field1 = ? AND $field2 = ?',
      whereArgs: [arg1, arg2],
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  Future<int> deleteTwoFields({
    required DbBaseModel object,
    required String field1,
    required String field2,
    required arg1,
    required arg2,
  }) async {
    return db.delete(
      table,
      where: '$field1 = ? AND $field2 = ?',
      whereArgs: [arg1, arg2],
    );
  }

  Future<List<Map<String, dynamic>>> getMultipleField({
    required List<String> columns,
    required List args,
    int? limit,
  }) async {
    var whereQuery = '';
    for (var i = 0; i < columns.length; i++) {
      if (i == columns.length - 1) {
        whereQuery = '$whereQuery${columns[i]} =? ';
      } else {
        whereQuery = '$whereQuery${columns[i]}=? and ';
      }
    }
    return db.query(
      table,
      where: whereQuery,
      whereArgs: args,
      limit: limit,
    );
  }
}
