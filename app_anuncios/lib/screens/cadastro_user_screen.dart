import 'dart:convert';
import 'package:app_anuncios/models/usuario.dart';
import 'package:app_anuncios/services/usuario_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CadastroUser extends StatefulWidget {
  Usuario user;
  CadastroUser({this.user});

  @override
  _CadastroUserState createState() => _CadastroUserState();
}

class _CadastroUserState extends State<CadastroUser> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _userId;

  @override
  void initState() {
    super.initState();

    if (widget.user != null) {
      setState(() {
        _usernameController.text = widget.user.nome;
        _telefoneController.text = widget.user.telefone;
        _senhaController.text = widget.user.senha;
        _userId = widget.user.id;
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
              Container(
                child: Text(
                  "Nome de Usuário",
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
                  controller: _usernameController,
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
                  "Senha",
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
                  controller: _senhaController,
                  style: TextStyle(fontSize: 16),
                  obscureText: true,
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
                  "Telefone",
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
                  controller: _telefoneController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 16),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Campo obrigatório";
                    } else if (!RegExp(r'^[0-9]*$').hasMatch(value)) {
                      return "Somente números";
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
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            UsuarioService userService = UsuarioService();
                            Map<String, dynamic> data = {
                              "id": _userId == null ? 0 : _userId,
                              "nome": _usernameController.text,
                              "senha": _senhaController.text,
                              "telefone": _telefoneController.text
                            };
                            Usuario user =
                                Usuario().usuarioFromJson(jsonEncode(data));

                            await userService.createOrUpdateUser(user);
                            Navigator.pop(context, user);
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
