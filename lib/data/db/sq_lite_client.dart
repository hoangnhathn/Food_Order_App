import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dao/db_cart_info_dao.dart';
import 'dao/db_food_info_dao.dart';
import 'dao/db_order_info_dao.dart';
import 'dao/db_order_item_info_dao.dart';
import 'dao/db_shop_info_dao.dart';
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
  DbShopInfoDao? _dbShopInfoDao;
  DbFoodInfoDao? _dbFoodInfoDao;
  DbCartInfoDao? _dbCartInfoDao;
  DbOrderInfoDao? _dbOrderInfoDao;
  DbOrderItemInfoDao? _dbOrderItemInfoDao;

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
    await createShopInfoTable(db);
    await createFoodInfoTable(db);
    await createCartInfoTable(db);
    await createOrderInfoTable(db);
    await createOrderItemInfoTable(db);
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

  Future<void> createShopInfoTable(Database db) async {
    return db.execute(
      '''
        CREATE TABLE ${DbTableNames.shopInfo}(
          ${DbShopInfoFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${DbShopInfoFields.name} TEXT UNIQUE,
          ${DbShopInfoFields.title} TEXT,
          ${DbShopInfoFields.banner} TEXT,
          ${DbShopInfoFields.rating} REAL,
          ${DbShopInfoFields.comment} INTEGER,
          ${DbShopInfoFields.time} INTEGER,
          ${DbShopInfoFields.distance} INTEGER 
        )
      ''',
    );
  }

  Future<void> createFoodInfoTable(Database db) async {
    return db.execute(
      '''
        CREATE TABLE ${DbTableNames.foodInfo}(
          ${DbFoodInfoFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${DbFoodInfoFields.shopInfoId} INTEGER,
          ${DbFoodInfoFields.title} TEXT UNIQUE,
          ${DbFoodInfoFields.banner} TEXT,
          ${DbFoodInfoFields.favorite} INTEGER,
          ${DbFoodInfoFields.price} REAL,
          ${DbFoodInfoFields.sold} INTEGER,
          ${DbFoodInfoFields.category} INTEGER,
          FOREIGN KEY (${DbFoodInfoFields.shopInfoId})
          REFERENCES ${DbTableNames.shopInfo}(${DbShopInfoFields.id})
        )
      ''',
    );
  }

  Future<void> createCartInfoTable(Database db) async {
    return db.execute(
      '''
        CREATE TABLE ${DbTableNames.cartInfo}(
          ${DbCartInfoFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${DbCartInfoFields.quantity} INTEGER,
          ${DbCartInfoFields.price} REAL,
          ${DbCartInfoFields.time} TEXT,
          ${DbCartInfoFields.userInfoId} INTEGER,
          ${DbCartInfoFields.foodInfoId} INTEGER,
          FOREIGN KEY (${DbCartInfoFields.userInfoId})
          REFERENCES ${DbTableNames.userInfo}(${DbUserInfoFields.id}),
          FOREIGN KEY (${DbCartInfoFields.foodInfoId})
          REFERENCES ${DbTableNames.foodInfo}(${DbFoodInfoFields.id})
        )
      ''',
    );
  }

  Future<void> createOrderInfoTable(Database db) async {
    return db.execute(
      '''
        CREATE TABLE ${DbTableNames.orderInfo}(
          ${DbOrderInfoFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${DbOrderInfoFields.time} TEXT,
          ${DbOrderInfoFields.userInfoId} INTEGER,
          ${DbOrderInfoFields.shopInfoId} INTEGER,
          FOREIGN KEY (${DbOrderInfoFields.userInfoId})
          REFERENCES ${DbTableNames.userInfo}(${DbUserInfoFields.id}),
          FOREIGN KEY (${DbOrderInfoFields.shopInfoId})
          REFERENCES ${DbTableNames.shopInfo}(${DbShopInfoFields.id})
        )
      ''',
    );
  }

  Future<void> createOrderItemInfoTable(Database db) async {
    return db.execute(
      '''
        CREATE TABLE ${DbTableNames.orderItemInfo}(
          ${DbOrderItemInfoFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${DbOrderItemInfoFields.quantity} INTEGER,
          ${DbOrderItemInfoFields.price} REAL,
          ${DbOrderItemInfoFields.title} TEXT,
          ${DbOrderItemInfoFields.banner} INTEGER,
          ${DbOrderItemInfoFields.foodInfoId} INTEGER,
          ${DbOrderItemInfoFields.orderInfoId} INTEGER,
          FOREIGN KEY (${DbOrderItemInfoFields.foodInfoId})
          REFERENCES ${DbTableNames.foodInfo}(${DbFoodInfoFields.id}),
          FOREIGN KEY (${DbOrderItemInfoFields.orderInfoId})
          REFERENCES ${DbTableNames.orderInfo}(${DbOrderInfoFields.id})
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

  Future<DbShopInfoDao> get dbShopInfoDao async {
    if (_dbShopInfoDao != null) {
      return _dbShopInfoDao!;
    }
    final db = await _db;
    _dbShopInfoDao = DbShopInfoDao(db: db);
    return _dbShopInfoDao!;
  }

  Future<DbFoodInfoDao> get dbFoodInfoDao async {
    if (_dbFoodInfoDao != null) {
      return _dbFoodInfoDao!;
    }
    final db = await _db;
    _dbFoodInfoDao = DbFoodInfoDao(db: db);
    return _dbFoodInfoDao!;
  }

  Future<DbCartInfoDao> get dbCartInfoDao async {
    if (_dbCartInfoDao != null) {
      return _dbCartInfoDao!;
    }
    final db = await _db;
    _dbCartInfoDao = DbCartInfoDao(db: db);
    return _dbCartInfoDao!;
  }

  Future<DbOrderInfoDao> get dbOrderInfoDao async {
    if (_dbOrderInfoDao != null) {
      return _dbOrderInfoDao!;
    }
    final db = await _db;
    _dbOrderInfoDao = DbOrderInfoDao(db: db);
    return _dbOrderInfoDao!;
  }

  Future<DbOrderItemInfoDao> get dbOrderItemInfoDao async {
    if (_dbOrderItemInfoDao != null) {
      return _dbOrderItemInfoDao!;
    }
    final db = await _db;
    _dbOrderItemInfoDao = DbOrderItemInfoDao(db: db);
    return _dbOrderItemInfoDao!;
  }
}
