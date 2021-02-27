import 'dart:io';
import 'package:app_anuncios/models/anuncio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CadastroScreen extends StatefulWidget {
  Anuncio ads;
  CadastroScreen({this.ads});
  // CadastroScreen({Key key}) : super(key: key);

  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File _image;
  int _id;
  @override
  void initState() {
    super.initState();
    if (widget.ads != null) {
      setState(() {
        _tituloController.text = widget.ads.titulo;
        _descricaoController.text = widget.ads.descricao;
        _precoController.text = widget.ads.preco.toString();
        _image = widget.ads.image;
        _id = widget.ads.id;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Anúncio"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    border: Border.all(width: 1),
                    shape: BoxShape.circle,
                  ),
                  child: _image == null
                      ? Icon(
                          Icons.add_a_photo,
                          size: 30,
                        )
                      : ClipOval(
                          child: Image.file(_image),
                        ),
                ),
                onTap: () async {
                  final picker = ImagePicker();
                  final pickedFile =
                      await picker.getImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    setState(() {
                      _image = File(pickedFile.path);
                    });
                  }
                },
              ),
              Container(
                child: Text(
                  "Título do anúncio",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
              ),
              Container(
                child: TextFormField(
                  controller: _tituloController,
                  style: TextStyle(fontSize: 16),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Campo obrigatório";
                    }
                  },
                ),
                margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
              ),
              Container(
                child: Text(
                  "Descrição do produto",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              ),
              Container(
                child: TextFormField(
                  controller: _descricaoController,
                  style: TextStyle(fontSize: 16),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Campo obrigatório";
                    }
                  },
                ),
                margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
              ),
              Container(
                child: Text(
                  "Preço do produto (R\$)",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              ),
              Container(
                child: TextFormField(
                  controller: _precoController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 16),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Campo obrigatório";
                    } else if (RegExp(r'^.*[,-].*$').hasMatch(value)) {
                      return "Caracteres permitidos: 0-9.";
                    }
                  },
                ),
                margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      padding: EdgeInsets.only(left: 20, right: 10),
                      height: 40,
                      child: RaisedButton(
                        child: Text("Cadastrar"),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            Anuncio ads = Anuncio(
                              _tituloController.text,
                              _descricaoController.text,
                              double.parse(_precoController.text),
                              _image,
                            );
                            ads.id = _id;
                            Navigator.pop(context, ads);
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      padding: EdgeInsets.only(left: 10, right: 20),
                      height: 40,
                      child: RaisedButton(
                        child: Text("Cancelar"),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
