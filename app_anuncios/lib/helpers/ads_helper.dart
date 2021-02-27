import 'package:app_anuncios/models/anuncio.dart';
import 'package:app_anuncios/helpers/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class AdsHelper {
  static final String tableName = 'ads';
  static final String idColumn = '_id';
  static final String tituloColumn = 'titulo';
  static final String descColumn = 'descricao';
  static final String precoColumn = 'preco';

  static String get createScript {
    return "CREATE TABLE $tableName($idColumn INTEGER PRIMARY KEY AUTOINCREMENT," +
        "$tituloColumn TEXT, $descColumn TEXT, $precoColumn REAL);";
  }

  Future<Anuncio> saveAds(Anuncio ads) async {
    Database db = await DatabaseHelper().db;
    ads.id = await db.insert(tableName, ads.toMap());
    return ads;
  }

  Future<List<Anuncio>> getAll() async {
    Database db = await DatabaseHelper().db;

    List<Map> maps = await db.query(tableName,
        columns: [idColumn, tituloColumn, descColumn, precoColumn]);
    List<Anuncio> adsList = List<Anuncio>();

    if (maps != null) {
      maps.forEach((element) {
        adsList.add(Anuncio.fromMap(element));
      });
    }

    return adsList;
  }

  Future<Anuncio> getById(int id) async {
    Database db = await DatabaseHelper().db;
    List<Map> maps = await db.query(tableName,
        columns: [idColumn, tituloColumn, descColumn, precoColumn],
        where: "$idColumn = ?",
        whereArgs: [id]);
    return Anuncio.fromMap(maps.first);
  }

  Future<int> editAnuncio(Anuncio ads) async {
    Database db = await DatabaseHelper().db;
    return await db.update(tableName, ads.toMap(),
        where: "$idColumn = ?", whereArgs: [ads.id]);
  }

  Future<int> deleteAnuncio(int id) async {
    Database db = await DatabaseHelper().db;
    return await db.delete(tableName, where: "$idColumn = ?", whereArgs: [id]);
  }
}
