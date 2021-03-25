import 'dart:convert';

class Usuario {
  int id;
  String nome;
  String senha;
  String telefone;

  Usuario({this.id, this.nome, this.senha, this.telefone});

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        nome: json["nome"],
        senha: json["senha"],
        telefone: json["telefone"],
      );
  Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "senha": senha,
        "telefone": telefone,
      };
  String usuarioToJson(Usuario data) => json.encode(data.toJson());

  @override
  String toString() {
    return "Id: $id, Nome: $nome, Senha: $senha, Telefone: $telefone";
  }
}
