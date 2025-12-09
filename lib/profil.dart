import 'package:flutter/material.dart';

import 'essayer.dart';
import 'accueil.dart';
import 'favoris.dart';


class Profil extends StatelessWidget {
  const Profil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        backgroundColor: Colors.blueAccent,
      ),
      body: const Center(
        child: Text("Page Profil"),
      ),
    );
  }
}
