import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'inscription.dart';
import 'navigation_root.dart';

class Connexion extends StatefulWidget {
  const Connexion({super.key});

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      
      if (!mounted) return;
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const NavigationRoot(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? "Une erreur est survenue"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Row(
          children: [
            Image.asset("assets/images/logo.png", height: 30)
          ],
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
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: "email@example.com",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),
            const Text("Password"),
            const SizedBox(height: 5),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
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
                onPressed: _login,
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
