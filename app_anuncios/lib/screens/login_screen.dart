import 'package:app_anuncios/helpers/login_helper.dart';
import 'package:app_anuncios/screens/cadastro_user_screen.dart';
import 'package:app_anuncios/screens/home_screen.dart';
import 'package:app_anuncios/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("App de Anúncios"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  child: Text(
                    "Telefone",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  margin: EdgeInsets.fromLTRB(0, 75, 0, 10),
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
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        padding: EdgeInsets.only(left: 20, right: 10),
                        height: 40,
                        child: RaisedButton(
                            child: Text("Entrar"),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                LoginService loginService = LoginService();

                                String token = await loginService.logIn(
                                    _telefoneController.text,
                                    _senhaController.text);

                                if (token != "") {
                                  LoginHelper().setToken(token);
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()));
                                } else {
                                  print("Deu ruim na hr de logar");
                                }
                              }
                            }),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        padding: EdgeInsets.only(left: 10, right: 20),
                        height: 40,
                        child: RaisedButton(
                          child: Text("Registrar"),
                          color: Theme.of(context).primaryColor,
                          onPressed: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CadastroUser()));
                          },
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
