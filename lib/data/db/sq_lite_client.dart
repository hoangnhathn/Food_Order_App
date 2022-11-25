import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dao/db_user_info_dao.dart';
import 'db_tables.dart';

const String databaseName = 'food_order_app.db';
const int _databaseVersion1 = 1;
const int _databaseVersion2 = 2;

class SQFLiteClient {
  SQFLiteClient(this.read);

  final Ref read;

  Database? _database;
  DbUserInfoDao? _dbUserInfoDao;

  Future<Database> get _db async {
    if (_database != null) {
      return _database!;
    }
    _database = await init();
    return _database!;
  }

  Future<Database> init() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, databaseName);
    final database = openDatabase(
      dbPath,
      version: _databaseVersion2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onConfigure: _onConfigure,
    );
    return database;
  }

  Future<void> _onCreate(Database db, int version) async {
    final batch = db.batch();
    await createTable(db);
    await batch.commit();
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    final batch = db.batch();
    if (oldVersion == _databaseVersion1) {}
    await batch.commit();
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _deleteAll() async {}
}

extension SQFLiteClientCreateTableExtension on SQFLiteClient {
  Future<void> createTable(Database db) async {
    await createLoginInfoTable(db);
    await createUserInfoTable(db);
  }

  Future<void> createLoginInfoTable(Database db) async {}

  Future<void> createUserInfoTable(Database db) async {
    return db.execute(
      '''
        CREATE TABLE ${DbTableNames.userInfo}(
          ${DbLoginInfoFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${DbLoginInfoFields.username} TEXT UNIQUE,
          ${DbLoginInfoFields.password} TEXT
        )
      ''',
    );
  }

  Future<DbUserInfoDao> get dbUserInfoDao async {
    if (_dbUserInfoDao != null) {
      return _dbUserInfoDao!;
    }
    final db = await _db;
    _dbUserInfoDao = DbUserInfoDao(db: db);
    return _dbUserInfoDao!;
  }
}
