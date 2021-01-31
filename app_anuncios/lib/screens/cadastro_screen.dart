import 'package:app_anuncios/models/anuncio.dart';
import 'package:flutter/material.dart';

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
  Anuncio ads;

  @override
  void initState() {
    super.initState();
    if (widget.ads != null) {
      setState(() {
        _tituloController.text = widget.ads.titulo;
        _descricaoController.text = widget.ads.descricao;
        _precoController.text = widget.ads.preco.toString();
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
      body: Form(
        key: _formKey,
        child: Column(
          children: [
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
                          );
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
    );
  }
}
