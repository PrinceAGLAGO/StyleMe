import 'package:flutter/material.dart';
import 'presentation.dart'; // Ta page de présentation / splash

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StyleMe App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Presentation(), // Page de démarrage
    );
  }
}
