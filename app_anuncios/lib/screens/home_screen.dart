import 'package:app_anuncios/helpers/ads_helper.dart';
import 'package:app_anuncios/models/anuncio.dart';
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
  AdsHelper _adsHelper = AdsHelper();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _adsHelper.getAll().then((data) {
      if (data != null) {
        setState(() {
          _lista = data;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              await _adsHelper.deleteAnuncio(_lista[index].id);

              setState(() {
                _lista.removeAt(index);
              });
            },
            child: Card(
                child: ListTile(
                    title: Text(_lista[index].titulo),
                    subtitle: Text(_lista[index].descricao),
                    trailing: Text("R\$ ${_lista[index].preco}"),
                    leading: _lista[index].image == null
                        ? Icon(Icons.star_border_outlined)
                        : CircleAvatar(
                            child: ClipOval(
                              child: Image.file(
                                _lista[index].image,
                                width: 200,
                                height: 200,
                              ),
                            ),
                          ),
                    onTap: () async {
                      Anuncio ads = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CadastroScreen(ads: _lista[index]),
                          ));
                      if (ads != null) {
                        await _adsHelper.editAnuncio(ads);
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
          Anuncio ads = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => CadastroScreen()));

          if (ads != null) {
            await _adsHelper.saveAds(ads);

            setState(() {
              _lista.add(ads);
            });
          }
        },
      ),
    );
  }
}
