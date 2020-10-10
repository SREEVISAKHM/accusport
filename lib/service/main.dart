import 'package:flutter/material.dart';
import 'package:sports/page/sports.dart';

void main() => runApp(Sports());

class Sports extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Home(),
    );
  }
}
