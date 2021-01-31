import 'package:app_anuncios/models/anuncio.dart';
import 'package:flutter/material.dart';
import 'cadastro_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Anuncio> _lista = List();

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
            onDismissed: (direction) {
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
                  onLongPress: () async {
                    Anuncio ads = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CadastroScreen(ads: _lista[index]),
                        ));
                    if (ads != null) {
                      setState(() {
                        _lista.removeAt(index);
                        _lista.insert(index, ads);
                      });
                    }
                  },
                ),
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
            setState(() {
              _lista.add(ads);
            });
          }
        },
      ),
    );
  }
}
