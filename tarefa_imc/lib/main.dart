import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController alturaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  var _resultado = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cálculo de IMC"),
        centerTitle: true,
        backgroundColor: Colors.teal[900],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
                child: Text(
                  "Qual o seu IMC?",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                child: Text(
                  _resultado,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 80),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Altura",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: alturaController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            fontSize: 20,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal[900]),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal[900]),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal[900]),
                          ),
                          helperText: "Ex: 1.70m",
                          helperStyle: TextStyle(fontStyle: FontStyle.italic),
                          suffix: Text("m"),
                        ),
                        cursorColor: Colors.teal[900],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Peso",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: pesoController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            fontSize: 20,
                          ),
                          border: OutlineInputBorder(),
                          helperText: "Ex: 75Kg",
                          helperStyle: TextStyle(fontStyle: FontStyle.italic),
                          suffix: Text("Kg"),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal[900]),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal[900]),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal[900]),
                          ),
                        ),
                        cursorColor: Colors.teal[900],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
                child: RaisedButton(
                  child: Text(
                    "Calcular",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.teal[900],
                  onPressed: () {
                    double altura = double.parse(alturaController.text);
                    double peso = double.parse(pesoController.text);

                    double resultado = peso / (altura * altura);
                    setState(
                      () {
                        if (resultado < 18.5)
                          _resultado = "Abaixo do peso";
                        else if (resultado >= 18.6 && resultado < 24.9)
                          _resultado = "Peso ideal (parabéns)";
                        else if (resultado >= 25 && resultado < 29.9)
                          _resultado = "Levemente acima do peso";
                        else if (resultado >= 30 && resultado < 34.9)
                          _resultado = "Obesidade grau 1";
                        else if (resultado >= 35 && resultado < 39.9)
                          _resultado = "Obesidade grau 2 (severa)";
                        else if (resultado > 40)
                          _resultado = "Obesidade 3 (mórbida)";
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
