import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:app_anuncios/helpers/ads_helper.dart';

class DatabaseHelper {
  Database _db;

  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;
  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'adsList.db');

    try {
      return _db = await openDatabase(path,
          version: 4, onCreate: _onCreateDB, onUpgrade: _onUpgrade);
    } catch (e) {
      print(e);
    }
  }

  Future _onCreateDB(Database db, int newerVersion) async {
    await db.execute(AdsHelper.createScript);
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await db.execute("DROP TABLE ${AdsHelper.tableName};");
      await _onCreateDB(db, newVersion);
    }
  }
}