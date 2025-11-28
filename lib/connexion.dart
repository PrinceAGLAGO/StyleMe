import 'package:flutter/material.dart';

class Connexion extends StatelessWidget {
  const Connexion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text("StyleMe", style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "S'inscrire",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Email"),
            const SizedBox(height: 5),
            const TextField(
              decoration: InputDecoration(
                hintText: "email@example.com",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),
            const Text("Password"),
            const SizedBox(height: 5),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Mot de passe",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(value: true, onChanged: (v) {}),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Label"), Text("Description")],
                ),
              ],
            ),

            const SizedBox(height: 20),

            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 80,
                    vertical: 14,
                  ),
                ),
                child: const Text(
                  "Connecter",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
