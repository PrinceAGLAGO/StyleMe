import 'package:flutter/material.dart';
import 'connexion.dart';
import 'inscription.dart';

class Presentation extends StatelessWidget {
  const Presentation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // --- IMAGE DE FOND ---
          
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "assets/images/image1.png",
              fit: BoxFit.cover,
            ),
          ),

          // --- DEGRADÉ VIOLET / ROSE / BLEU ---
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.purple.withOpacity(0.8),
                  Colors.pink.withOpacity(0.7),
                  Colors.blue.withOpacity(0.7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // --- CONTENU PRINCIPAL ---
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // Texte "Bienvenue sur"
                const Text(
                  "Bienvenue sur",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                //Logo StyleMe

                 Image.asset(
                  "assets/images/logo.png", 
                  height: 80,
                ),
                const SizedBox(height: 20),


                const SizedBox(height: 50),

                // --- BOUTON CONNEXION ---
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Connexion()),
                      );
                    },
                    child: const Text(
                      "Connexion",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // --- BOUTON INSCRIPTION ---
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Inscription()),
                      );
                    },
                    child: const Text(
                      "Inscription",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}