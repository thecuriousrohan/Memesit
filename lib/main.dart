
import 'package:flutter/material.dart';
import 'package:newemesit/login.dart';
import 'package:newemesit/register.dart';
import 'package:newemesit/screen/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyLogin(),
    routes: {
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
      'home': (context) => MyHomePage(),
    },
  ));
}
