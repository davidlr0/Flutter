import 'dart:convert';

import 'package:app_anuncios/helpers/login_helper.dart';
import 'package:http/http.dart' as http;

class LoginService {
  Future<String> logIn(String telefone, String senha) async {
    final url = await 'http://anuncios.marcelmelo.com.br/login';

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({"telefone": telefone, "senha": senha}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['token'];
    } else {
      return "";
    }
  }

  Future<String> logOut() async {
    final url = await 'http://anuncios.marcelmelo.com.br/logout';

    final response = await http.post(url,
        headers: <String, String>{'Authorization': '${LoginHelper().token}'});

    if (response.statusCode == 200) {
      LoginHelper().removeToken();
      return "Logout feito";
    } else {
      return "";
    }
  }
}
