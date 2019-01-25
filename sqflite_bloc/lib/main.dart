import "package:flutter/material.dart";
import 'package:sqflite_bloc/HomePage.dart';
import 'package:sqflite_bloc/user_detail.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Sqflite",
      initialRoute: "/",
      routes: {
        "/": (context) => HomePage(),
        "/detail": (context) => UserDetail()
      },
    );
  }
}
