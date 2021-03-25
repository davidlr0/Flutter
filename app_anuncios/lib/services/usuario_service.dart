import 'dart:convert';

import 'package:app_anuncios/helpers/login_helper.dart';
import 'package:app_anuncios/models/usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioService {
  Future<Usuario> getUser() async {
    final url = await 'http://anuncios.marcelmelo.com.br/usuario';
    final response = await http.get(url,
        headers: <String, String>{'Authorization': '${LoginHelper().token}'});

    if (response.statusCode == 200) {
      return Usuario.fromJson(jsonDecode(response.body));
    } else {
      Exception("Falha na conexão com o servidor!");
    }
  }

  Future<Usuario> createOrUpdateUser(Usuario usuario) async {
    final url = await 'http://anuncios.marcelmelo.com.br/usuario';

    var response;
    if (usuario.id == 0) {
      response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(usuario.toJson()),
      );
    } else {
      print(usuario);
      response = await http.put(
        url,
        headers: <String, String>{
          'Authorization': '${LoginHelper().token}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(usuario.toJson()),
      );
    }

    print(response.statusCode);
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Usuario.fromJson(jsonDecode(response.body));
    } else {
      Exception("Falha na conexão com o servidor!");
    }
  }
}
