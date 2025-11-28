import 'package:flutter/material.dart';
import 'inscription.dart';
import 'navigation_root.dart'; // Assure-toi que NavigationRoot.dart est bien importé

class Connexion extends StatelessWidget {
  const Connexion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Row(
          children: [Image.asset("assets/images/logo.png", height: 30)],
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Inscription()),
              );
            },
            icon: const Icon(Icons.person_add, color: Colors.white),
            label: const Text(
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
                onPressed: () {
                  // 🔹 Redirection vers NavigationRoot après connexion
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NavigationRoot(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 80,
                    vertical: 14,
                  ),
                ),
                child: const Text(
                  "Se connecter",
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
