import 'package:eltodo/screens/home_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: ThemeData(
        primarySwatch: Colors.red
      ),
    );
  }
}