import 'package:flutter/material.dart';
import 'package:app_anuncios/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Anúncios',
      theme: ThemeData(
          primaryColor: Colors.pink,
          // primarySwatch: Colors.lightBlue,
          secondaryHeaderColor: Colors.lightBlue[300],
          cursorColor: Colors.pink,
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(
              fontSize: 20,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.pink),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.pink),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.pink),
            ),
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.pink,
            textTheme: ButtonTextTheme.primary,
          )),
      home: HomeScreen(),
    );
  }
}
