import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'providers/authentication_provider.dart';
import 'providers/user_provider.dart';
import 'connexion.dart';

class Profil extends StatelessWidget {
  const Profil({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthenticationProvider, UserProvider>(
      builder: (context, authProvider, userProvider, child) {
        final user = authProvider.user;
        final userData = userProvider.userData;
        final favorisCount = userProvider.favoris.length;
        final historiqueCount = userProvider.historiqueLooks.length;

        return Scaffold(
          backgroundColor: const Color(0xfff5f5f5),
          body: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(context, user, userData, authProvider, favorisCount, historiqueCount, userProvider),
                const SizedBox(height: 20),
                _card(child: _buildUserInfo(context, userData, user)),
                const SizedBox(height: 20),
                _card(child: _buildMorphology(context, userProvider)),
                const SizedBox(height: 20),
                _card(child: _buildStylePreferences(context, userProvider)),
                const SizedBox(height: 20),
                _card(child: _buildNotifications(userProvider)),
                const SizedBox(height: 20),
                _card(child: _buildMenu(context, authProvider, userProvider)),
                const SizedBox(height: 20),
                _buildLogoutButton(context, authProvider),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, User? user, Map<String, dynamic> userData, AuthenticationProvider authProvider, int favorisCount, int historiqueCount, UserProvider userProvider) {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Colors.purple, Colors.pink]),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Mon Profil",
                style: TextStyle(color: Colors.white, fontSize: 26),
              ),
              Row(
                children: [
                  _iconBtn(Icons.notifications),
                  const SizedBox(width: 10),
                  _iconBtn(Icons.settings),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => _pickImage(context, userProvider),
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Colors.pink, Colors.purple],
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            userData['photoUrl'] != null && userData['photoUrl'].toString().isNotEmpty
                                ? ClipOval(
                                    child: kIsWeb
                                        ? Image.network(
                                            userData['photoUrl'].toString(),
                                            width: 60,
                                            height: 60,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return const Text("👤", style: TextStyle(fontSize: 28));
                                            },
                                          )
                                        : Image.network(
                                            userData['photoUrl'].toString(),
                                            width: 60,
                                            height: 60,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return const Text("👤", style: TextStyle(fontSize: 28));
                                            },
                                          ),
                                  )
                                : const Text("👤", style: TextStyle(fontSize: 28)),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.camera_alt, size: 12, color: Colors.pink),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getDisplayName(userData, user),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            _getEmail(userData, user),
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => _openEditModal(context, userData, user, userProvider),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.24),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.edit, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _stat(icon: Icons.favorite, value: "$favorisCount", label: "Looks"),
                    _stat(icon: Icons.star, value: "4", label: "Collections"),
                    _stat(icon: Icons.trending_up, value: "$historiqueCount", label: "Essayages"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getDisplayName(Map<String, dynamic> userData, User? user) {
    if (userData['nom'] != null && userData['nom'].toString().isNotEmpty) {
      return userData['nom'].toString();
    }
    if (user?.displayName != null && user!.displayName!.isNotEmpty) {
      return user.displayName!;
    }
    if (user?.email != null) {
      final email = user!.email!;
      return email.split('@')[0];
    }
    return 'Utilisateur';
  }

  String _getEmail(Map<String, dynamic> userData, User? user) {
    if (userData['email'] != null && userData['email'].toString().isNotEmpty) {
      return userData['email'].toString();
    }
    return user?.email ?? 'Non renseigné';
  }

  Widget _buildUserInfo(BuildContext context, Map<String, dynamic> userData, User? user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Informations personnelles",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        _infoRow("Nom complet", _getDisplayName(userData, user)),
        _infoRow("Email", _getEmail(userData, user)),
        _infoRow("Taille", "${userData['taille'] ?? 170} cm"),
        _infoRow("Poids", "${userData['poids'] ?? 65} kg"),
        _infoRow("Couleur de peau", userData['couleurPeau']?.toString() ?? 'Moyenne'),
      ],
    );
  }

  Widget _buildMorphology(BuildContext context, UserProvider userProvider) {
    final morphologies = ['Standard', 'Mince', 'Athlétique', 'Ronde'];
    final selectedMorphology = userProvider.userData['morphologie']?.toString() ?? 'Standard';
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Information Morphologie",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () => _openMorphologyEditModal(context, userProvider),
              child: const Text(
                "Modifier",
                style: TextStyle(color: Colors.pink, fontSize: 14),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        _infoRow("Morphologie", selectedMorphology),
        const Divider(),
        _infoRow("Taille", "M / 38-40"),
        const Divider(),
        _infoRow("Hauteur", "${userProvider.userData['taille'] ?? 170} cm"),
        const SizedBox(height: 10),
        const Text(
          "Couleurs préférées",
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _colorCircle(Colors.pink),
            const SizedBox(width: 6),
            _colorCircle(Colors.black),
            const SizedBox(width: 6),
            _colorCircle(Colors.blue),
          ],
        ),
        const SizedBox(height: 15),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: morphologies.map((morphologie) {
            final isSelected = selectedMorphology == morphologie;
            return FilterChip(
              label: Text(morphologie),
              selected: isSelected,
              onSelected: (selected) {
                userProvider.updateMorphologie(morphologie);
              },
              backgroundColor: Colors.grey[200],
              selectedColor: Colors.orange,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStylePreferences(BuildContext context, UserProvider userProvider) {
    final preferences = List<String>.from(userProvider.userData['stylePreferences'] as List? ?? []);
    final allStyles = ['Casual', 'Chic', 'Sport', 'Élégant', 'Streetwear', 'Bohème'];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Préférences de style",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: allStyles.map((style) {
            final isSelected = preferences.contains(style);
            return FilterChip(
              label: Text(style),
              selected: isSelected,
              onSelected: (selected) {
                final newPreferences = List<String>.from(preferences);
                if (selected) {
                  newPreferences.add(style);
                } else {
                  newPreferences.remove(style);
                }
                userProvider.updateStylePreferences(newPreferences);
              },
              backgroundColor: Colors.grey[200],
              selectedColor: Colors.orange,
            );
          }).toList(),
        ),
        const SizedBox(height: 15),
        OutlinedButton(
          onPressed: () => _showAddStyleDialog(context, userProvider),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.grey),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text("+ Ajouter un style"),
        ),
      ],
    );
  }

  Widget _buildNotifications(UserProvider userProvider) {
    final notificationsEnabled = userProvider.userData['notificationsEnabled'] as bool? ?? true;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.pink.shade100,
              child: const Icon(Icons.notifications, color: Colors.pink),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Notifications"),
                Text(
                  "Nouvelles tendances et looks",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        Switch(
          value: notificationsEnabled,
          activeColor: Colors.pink,
          onChanged: (v) {
            userProvider.toggleNotifications();
          },
        ),
      ],
    );
  }

  Widget _buildMenu(BuildContext context, AuthenticationProvider authProvider, UserProvider userProvider) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.trending_up, color: Colors.grey),
          title: const Text("Historique des essayages"),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showHistorique(context, userProvider),
        ),
        const Divider(height: 1),
        ListTile(
          leading: const Icon(Icons.settings, color: Colors.grey),
          title: const Text("Paramètres du compte"),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showSettings(context, authProvider),
        ),
        const Divider(height: 1),
        ListTile(
          leading: const Icon(Icons.help_outline, color: Colors.grey),
          title: const Text("Aide et support"),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showHelp(context),
        ),
        const Divider(height: 1),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context, AuthenticationProvider authProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () async {
            await authProvider.signOut();
            if (context.mounted) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Connexion()),
                (route) => false,
              );
            }
          },
          child: Container(
            height: 55,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              "Se déconnecter",
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(BuildContext context, UserProvider userProvider) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      userProvider.setPhotoUrl(image.path);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Photo de profil mise à jour!"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _openEditModal(BuildContext context, Map<String, dynamic> userData, User? user, UserProvider userProvider) {
    TextEditingController name = TextEditingController(text: _getDisplayName(userData, user));
    TextEditingController email = TextEditingController(text: _getEmail(userData, user));

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 16,
            right: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Modifier le profil",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: name,
                decoration: const InputDecoration(labelText: "Nom complet"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: email,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Annuler"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                      ),
                      onPressed: () {
                        userProvider.updateUserData({
                          'nom': name.text,
                          'email': email.text,
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Profil mis à jour!"),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      child: const Text("Enregistrer"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void _openMorphologyEditModal(BuildContext context, UserProvider userProvider) {
    TextEditingController tailleController = TextEditingController(text: "${userProvider.userData['taille'] ?? 170}");
    TextEditingController poidsController = TextEditingController(text: "${userProvider.userData['poids'] ?? 65}");

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Modifier les informations"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: tailleController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Taille (cm)"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: poidsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Poids (kg)"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Annuler"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
              onPressed: () {
                userProvider.updateTaillePoids(
                  int.tryParse(tailleController.text) ?? 170,
                  int.tryParse(poidsController.text) ?? 65,
                );
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Informations mises à jour!"),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text("Enregistrer"),
            ),
          ],
        );
      },
    );
  }

  void _showAddStyleDialog(BuildContext context, UserProvider userProvider) {
    TextEditingController styleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Ajouter un style"),
          content: TextField(
            controller: styleController,
            decoration: const InputDecoration(
              labelText: "Nouveau style",
              hintText: "Ex: Vintage",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Annuler"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
              onPressed: () {
                if (styleController.text.isNotEmpty) {
                  final currentPreferences = List<String>.from(userProvider.userData['stylePreferences'] as List? ?? []);
                  currentPreferences.add(styleController.text);
                  userProvider.updateStylePreferences(currentPreferences);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Style ajouté!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: const Text("Ajouter"),
            ),
          ],
        );
      },
    );
  }

  void _showHistorique(BuildContext context, UserProvider userProvider) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Historique des essayages",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: userProvider.historiqueLooks.isEmpty
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.history, size: 64, color: Colors.grey),
                              SizedBox(height: 16),
                              Text(
                                "Aucun essayage pour le moment",
                                style: TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Commencez par essayer un look!",
                                style: TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: userProvider.historiqueLooks.length,
                          itemBuilder: (context, index) {
                            final look = userProvider.historiqueLooks[index];
                            return GestureDetector(
                              onTap: () => _showLookDetails(context, look),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.grey.shade200),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          color: Colors.grey.shade200,
                                          child: look['userImage'] != null
                                              ? _buildLookImage(look['userImage'])
                                              : const Icon(Icons.person, color: Colors.grey),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              look['title'] ?? "Look ${index + 1}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              _formatDate(look['date'] ?? look['timestamp']),
                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontSize: 12,
                                              ),
                                            ),
                                            if (look['clothingItem'] != null) ...[
                                              const SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.checkroom,
                                                    size: 14,
                                                    color: Colors.pink,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Expanded(
                                                    child: Text(
                                                      look['clothingItem']['name'] ?? '',
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.pink,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                      const Icon(Icons.chevron_right, color: Colors.grey),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
                if (userProvider.historiqueLooks.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            userProvider.clearHistorique();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Historique effacé!"),
                                backgroundColor: Colors.orange,
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.red),
                          ),
                          child: const Text(
                            "Effacer tout",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLookImage(String imagePath) {
    if (kIsWeb) {
      if (imagePath.startsWith('http')) {
        return Image.network(
          imagePath,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error, color: Colors.red, size: 24);
          },
        );
      } else {
        return Image.network(
          imagePath,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.image, color: Colors.grey, size: 24);
          },
        );
      }
    } else {
      return Image.file(
        File(imagePath),
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error, color: Colors.red, size: 24);
        },
      );
    }
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return "${date.day}/${date.month}/${date.year} à ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
    } catch (e) {
      return dateString;
    }
  }

  void _showLookDetails(BuildContext context, Map<String, dynamic> look) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      look['title'] ?? "Détails du look",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (look['userImage'] != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 200,
                      height: 250,
                      color: Colors.grey.shade200,
                      child: _buildLookImage(look['userImage']),
                    ),
                  ),
                const SizedBox(height: 16),
                Text(
                  "Date: ${_formatDate(look['date'] ?? look['timestamp'])}",
                  style: const TextStyle(fontSize: 14),
                ),
                if (look['clothingItem'] != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    "Vêtement: ${look['clothingItem']['name']}",
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Catégorie: ${look['clothingItem']['category']}",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Fermer"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Fonctionnalité de partage bientôt disponible!"),
                          ),
                        );
                      },
                      child: const Text("Partager"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSettings(BuildContext context, AuthenticationProvider authProvider) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Paramètres du compte"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: const Icon(Icons.lock),
                title: const Text("Changer le mot de passe"),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pop(context);
                  _showChangePasswordDialog(context, authProvider);
                },
              ),
              ListTile(
                leading: const Icon(Icons.privacy_tip),
                title: const Text("Confidentialité"),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pop(context);
                  _showPrivacyDialog(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text("Langue"),
                trailing: const Text("Français"),
                onTap: () {
                  Navigator.pop(context);
                  _showLanguageDialog(context);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Fermer"),
            ),
          ],
        );
      },
    );
  }

  void _showChangePasswordDialog(BuildContext context, AuthenticationProvider authProvider) {
    TextEditingController currentPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Changer le mot de passe"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: currentPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Mot de passe actuel"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Nouveau mot de passe"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Confirmer le mot de passe"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Annuler"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
              onPressed: () {
                if (newPasswordController.text == confirmPasswordController.text) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Mot de passe mis à jour!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Les mots de passe ne correspondent pas!"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text("Mettre à jour"),
            ),
          ],
        );
      },
    );
  }

  void _showPrivacyDialog(BuildContext context) {
    bool publicProfile = false;
    bool shareStats = true;
    bool receiveRecommendations = true;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Paramètres de confidentialité"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CheckboxListTile(
                    title: const Text("Profil public"),
                    subtitle: const Text("Tout le monde peut voir votre profil"),
                    value: publicProfile,
                    onChanged: (value) {
                      setState(() {
                        publicProfile = value!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text("Partager les statistiques"),
                    subtitle: const Text("Partager vos données d'utilisation anonymes"),
                    value: shareStats,
                    onChanged: (value) {
                      setState(() {
                        shareStats = value!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text("Recevoir des recommandations"),
                    subtitle: const Text("Basées sur vos préférences"),
                    value: receiveRecommendations,
                    onChanged: (value) {
                      setState(() {
                        receiveRecommendations = value!;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Fermer"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Paramètres de confidentialité sauvegardés!"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  child: const Text("Sauvegarder"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showLanguageDialog(BuildContext context) {
    final List<String> languages = ['Français', 'English', 'Español', 'Deutsch', '中文'];
    String selectedLanguage = 'Français';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Choisir la langue"),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: languages.length,
                  itemBuilder: (context, index) {
                    final language = languages[index];
                    return RadioListTile<String>(
                      title: Text(language),
                      value: language,
                      groupValue: selectedLanguage,
                      onChanged: (value) {
                        setState(() {
                          selectedLanguage = value!;
                        });
                      },
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Annuler"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Langue changée en $selectedLanguage!"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  child: const Text("Appliquer"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showHelp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Aide et support"),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(Icons.help_outline),
                title: Text("Centre d'aide"),
                subtitle: Text("FAQ et tutoriels"),
              ),
              ListTile(
                leading: Icon(Icons.contact_support),
                title: Text("Contactez-nous"),
                subtitle: Text("support@styleme.com"),
              ),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text("À propos"),
                subtitle: Text("Version 1.0.0"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Fermer"),
            ),
          ],
        );
      },
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: child,
    );
  }

  Widget _iconBtn(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.24),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Icon(icon, color: Colors.white),
    );
  }

  Widget _colorCircle(Color c) => Container(
    width: 25,
    height: 25,
    decoration: BoxDecoration(color: c, shape: BoxShape.circle),
  );

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(value),
      ],
    );
  }
}

class _stat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _stat({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 22, color: Colors.white),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 18)),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}
