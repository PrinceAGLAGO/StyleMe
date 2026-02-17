import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'connexion.dart';

class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _register() async {
    try {
      
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

   
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Compte créé avec succès ! Connectez-vous."),
          backgroundColor: Colors.green,
        ),
      );

 
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Connexion()),
      );
      
    } on FirebaseAuthException catch (e) {
      String message = "Une erreur est survenue";
      if (e.code == 'weak-password') message = "Le mot de passe est trop faible.";
      if (e.code == 'email-already-in-use') message = "Cet email est déjà utilisé.";
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    }
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Row(
          children: [Image.asset("assets/images/logo.png", height: 30)],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            const Text('Nom :', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87)),
            const SizedBox(height: 8),
            TextField(
              controller: _nomController,
              decoration: InputDecoration(
                hintText: 'Entrez votre nom',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              ),
            ),
            const SizedBox(height: 20),

            const Text('Prénom:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87)),
            const SizedBox(height: 8),
            TextField(
              controller: _prenomController,
              decoration: InputDecoration(
                hintText: 'Entrez votre prénom',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              ),
            ),
            const SizedBox(height: 20),

            const Text('Email:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87)),
            const SizedBox(height: 8),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Entrez votre email',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              ),
            ),
            const SizedBox(height: 20),

            const Text('Mot de passe:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black87)),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Entrez votre mot de passe',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              ),
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: _register,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade900,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text(
                'S\'inscrire',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Déjà un compte ? ', style: TextStyle(color: Colors.black87, fontSize: 14)),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Connexion()),
                    );
                  },
                  child: const Text(
                    'Connectez-vous',
                    style: TextStyle(color: Colors.orange, fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
