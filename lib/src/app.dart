import 'package:bannet_movil_t/src/View/Home/IndexScreen.dart';
import 'package:bannet_movil_t/src/View/Login/loginScreen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  final bool isLoggedIn;

  const MyApp({
    super.key,
    required this.isLoggedIn,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: widget.isLoggedIn ? const Indexscreen() : const Loginscreen(),
    );
  }
}
