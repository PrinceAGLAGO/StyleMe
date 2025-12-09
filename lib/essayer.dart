import 'package:flutter/material.dart';
import 'profil.dart';
import 'accueil.dart';
import 'favoris.dart';

class Essayer extends StatelessWidget {
  const Essayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Essayer"),
        backgroundColor: Colors.blueAccent,
      ),
      body: const Center(
        child: Text("Page Essayer"),
      ),
    );
  }
}
