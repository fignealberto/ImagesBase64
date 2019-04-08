import 'package:flutter/material.dart';
import 'PickAndCrop2.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      debugShowCheckedModeBanner: false,
      home: PickAndCrop2(),
    );
  }
}