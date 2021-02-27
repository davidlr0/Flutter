import 'dart:io';

class Anuncio {
  int id;
  String titulo, descricao;
  double preco;
  File image;

  Anuncio(this.titulo, this.descricao, this.preco, this.image);
  Map toMap() {
    Map<String, dynamic> map = {
      '_id': this.id,
      'titulo': this.titulo,
      'descricao': this.descricao,
      'preco': this.preco
    };
    return map;
  }

  Anuncio.fromMap(Map map) {
    this.id = map['_id'];
    this.titulo = map['titulo'];
    this.descricao = map['descricao'];
    this.preco = map['preco'];
  }

  @override
  String toString() =>
      "Anuncio (id: $id, titulo: $titulo, descricao: $descricao, preco: $preco";
}
