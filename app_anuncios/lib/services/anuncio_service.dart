import 'dart:convert';

import 'package:app_anuncios/helpers/login_helper.dart';
import 'package:app_anuncios/models/anuncio.dart';
import 'package:http/http.dart' as http;

class AnuncioService {
  Future<String> createOrUpdateAds(Anuncio ads) async {
    final url = await 'http://anuncios.marcelmelo.com.br/anuncios';
    var response;
    print(ads);
    if (ads.id == 0) {
      response = await http.post(
        url,
        headers: <String, String>{
          'Authorization': '${LoginHelper().token}',
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: json.encode(ads.toJson()),
      );
    } else {
      response = await http.put(
        url,
        headers: <String, String>{
          'Authorization': '${LoginHelper().token}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(ads.toJson()),
      );
    }

    if (response.statusCode == 201 || response.statusCode == 200) {
      return json.decode(response.body)['msg'];
    } else {
      Exception("Falha na conexão com o servidor!");
      return "";
    }
  }

  Future<List<Anuncio>> getAll() async {
    final url = await 'http://anuncios.marcelmelo.com.br/anuncios';
    var response;
    response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': '${LoginHelper().token}',
      },
    );

    if (response.statusCode == 200) {
      List<Anuncio> adsList = [];
      List responseList = jsonDecode(response.body);
      responseList.forEach((ads) {
        adsList.add(Anuncio.fromJson(ads));
      });

      return adsList;
    } else {
      Exception("Falha na conexão com o servidor!");
    }
  }

  Future<String> deleteAds(int id) async {
    final url = await 'http://anuncios.marcelmelo.com.br/anuncios/$id';
    var response;
    response = await http.delete(
      url,
      headers: <String, String>{
        'Authorization': '${LoginHelper().token}',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['msg'];
    } else {
      Exception("Falha na conexão com o servidor!");
    }
  }
}
