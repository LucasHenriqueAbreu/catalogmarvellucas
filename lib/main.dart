import 'package:catalogmarvellucas/pages/home/home_page.dart';
import 'package:catalogmarvellucas/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catálogo Marvel do Lucas',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: SplashPage(),
    );
  }
}
