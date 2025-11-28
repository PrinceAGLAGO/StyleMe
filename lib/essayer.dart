import 'package:flutter/material.dart';

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
