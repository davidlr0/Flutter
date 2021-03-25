import 'package:app_anuncios/models/anuncio.dart';
import 'package:app_anuncios/models/usuario.dart';
import 'package:app_anuncios/screens/cadastro_user_screen.dart';
import 'package:app_anuncios/screens/login_screen.dart';
import 'package:app_anuncios/services/anuncio_service.dart';
import 'package:app_anuncios/services/login_service.dart';
import 'package:app_anuncios/services/usuario_service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'cadastro_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Anuncio> _lista = List();
  Usuario _loggedUser = Usuario();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    AnuncioService().getAll().then((data) {
      if (data != null) {
        setState(() {
          _lista = data;
        });
      }
    });
    UsuarioService().getUser().then((user) {
      if (user != null) {
        setState(() {
          _loggedUser = user;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
            ListTile(
              leading: Icon(Icons.verified_user),
              title: Text('Perfil'),
              onTap: () async {
                Usuario user = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CadastroUser(user: _loggedUser),
                    ));
                if (user != null) {
                  setState(() {
                    _loggedUser = user;
                  });
                }
              },
            ),
            ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () {
                  LoginService().logOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                      (Route<dynamic> route) => false);
                }),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Lista de Anúncios",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _lista.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(_lista[index].titulo),
            background: Container(
              color: Theme.of(context).primaryColor,
              child: Align(
                alignment: Alignment(-0.8, 0.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) async {
              await AnuncioService().deleteAds(_lista[index].id);
              setState(() {
                _lista.removeAt(index);
              });
            },
            child: Card(
                child: ListTile(
                    title: Text(_lista[index].titulo),
                    subtitle: Text(_lista[index].descricao),
                    trailing: Text("R\$ ${_lista[index].preco}"),
                    leading: Icon(Icons.star_border_outlined),
                    onTap: () async {
                      Anuncio ads = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CadastroScreen(ads: _lista[index]),
                          ));
                      if (ads != null) {
                        await AnuncioService().createOrUpdateAds(ads);
                        setState(() {
                          _lista.removeAt(index);
                          _lista.insert(index, ads);
                        });
                      }
                    },
                    onLongPress: () async {
                      showBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: Icon(Icons.email),
                                  title: Text("Enviar por email"),
                                  onTap: () async {
                                    Navigator.pop(context);
                                    final Uri params = Uri(
                                      scheme: 'mailto',
                                      path: 'david@localhost.com',
                                      queryParameters: {
                                        'subject': '${_lista[index].titulo}',
                                        'body': 'Descrição do produto: ${_lista[index].descricao}.' +
                                            '\nPreço: R\$${_lista[index].preco}'
                                      },
                                    );
                                    final url = params.toString();
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      print("Erro ao enviar o email");
                                    }
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.sms),
                                  title: Text("Enviar um sms"),
                                  onTap: () async {
                                    Navigator.pop(context);
                                    final Uri params = Uri(
                                      scheme: 'sms',
                                      path: '+5564000000000',
                                      queryParameters: {
                                        'body': 'Produto: ${_lista[index].titulo}' +
                                            '\nDescrição do produto: ${_lista[index].descricao}.' +
                                            '\nPreço: R\$${_lista[index].preco}'
                                      },
                                    );
                                    final url = params.toString();
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      print("Erro ao enviar o sms");
                                    }
                                  },
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }),
                shadowColor: Theme.of(context).secondaryHeaderColor),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async {
          Anuncio ads = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CadastroScreen(
                        user: _loggedUser,
                      )));

          if (ads != null) {
            setState(() {
              _lista.add(ads);
            });
          }
        },
      ),
    );
  }
}
