import 'package:flutter/material.dart';

class Favoris extends StatelessWidget {
  const Favoris({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favoris"),
        backgroundColor: Colors.blueAccent,
      ),
      body: const Center(
        child: Text("Page Favoris"),
      ),
    );
  }
}
