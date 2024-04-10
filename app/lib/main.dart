import 'package:app/views/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App Segura',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Login());
  }
}
