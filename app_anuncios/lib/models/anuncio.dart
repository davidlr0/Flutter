import 'dart:convert';

Anuncio anuncioFromJson(String str) => Anuncio.fromJson(json.decode(str));

String anuncioToJson(Anuncio data) => json.encode(data.toJson());

class Anuncio {
  Anuncio({
    this.id,
    this.titulo,
    this.descricao,
    this.preco,
    this.usuarioId,
  });

  int id;
  String titulo;
  String descricao;
  double preco;
  int usuarioId;

  factory Anuncio.fromJson(Map<String, dynamic> json) => Anuncio(
        id: json["id"],
        titulo: json["titulo"],
        descricao: json["descricao"],
        preco: json["preco"].toDouble(),
        usuarioId: json["usuarioId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": titulo,
        "descricao": descricao,
        "preco": preco,
        "usuarioId": usuarioId,
      };

  @override
  String toString() {
    return "Id: $id, Titulo: $titulo, Descricao: $descricao, Preco: $preco, usuarioId: $usuarioId";
  }
}
