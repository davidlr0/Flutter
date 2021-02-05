import 'dart:ffi';

import 'dart:io';

class Anuncio {
  String titulo, descricao;
  double preco;
  File image;

  Anuncio(this.titulo, this.descricao, this.preco, this.image);
}
