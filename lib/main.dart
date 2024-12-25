import 'package:bannet_movil_t/IndexScreen.dart';
import 'package:bannet_movil_t/loginScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MiReciboScreen(),
    );
  }
}
