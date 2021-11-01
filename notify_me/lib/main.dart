import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';
import 'screens/homepage.dart';
import 'auth/authscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthScreen(),
      theme:ThemeData(brightness: Brightness.dark,primaryColor: Colors.purple),
    );
  }
}
