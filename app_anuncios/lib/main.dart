import 'package:flutter/material.dart';

import 'screens/login_screen.dart';

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
      home: LoginScreen(),
    );
  }
}
