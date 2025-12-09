import 'package:flutter/material.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),

            const SizedBox(height: 20),
            _card(child: _buildMorphology()),
            const SizedBox(height: 20),
            _card(child: _buildStylePreferences()),
            const SizedBox(height: 20),
            _buildRecommendations(),
            const SizedBox(height: 20),
            _card(child: _buildNotifications()),
            const SizedBox(height: 20),
            _card(child: _buildMenu()),

            const SizedBox(height: 20),
            _buildLogoutButton(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // -------------------- HEADER --------------------

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple, Colors.pink],
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Mon Profil",
                  style: TextStyle(color: Colors.white, fontSize: 26)),
              Row(
                children: [
                  _iconBtn(Icons.notifications),
                  const SizedBox(width: 10),
                  _iconBtn(Icons.settings),
                ],
              )
            ],
          ),

          const SizedBox(height: 20),

          // Profile card
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
                    // Avatar
                    Container(
                      height: 60,
                      width: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.pink, Colors.purple],
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text("👤", style: TextStyle(fontSize: 28)),
                    ),

                    const SizedBox(width: 15),

                    // Infos
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Prince AGLAGO",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                          SizedBox(height: 2),
                          Text("prince.aglago@gmail.com",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 13)),
                        ],
                      ),
                    ),

                    InkWell(
                      onTap: _openEditModal,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.edit, color: Colors.white),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    _stat(icon: Icons.favorite, value: "45", label: "Looks"),
                    _stat(icon: Icons.star, value: "4", label: "Collections"),
                    _stat(icon: Icons.trending_up, value: "128", label: "Essayages"),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  // -------------------- MORPHOLOGY --------------------

  Widget _buildMorphology() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleRow("Information Morphologie", "Modifier"),
        _infoRow("Morphologie", "Sablier (H)"),
        const Divider(),
        _infoRow("Taille", "M / 38-40"),
        const Divider(),
        _infoRow("Hauteur", "165 cm"),

        const SizedBox(height: 10),
        const Text("Couleurs préférées",
            style: TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 8),

        Row(
          children: [
            _colorCircle(Colors.pink),
            const SizedBox(width: 6),
            _colorCircle(Colors.black),
            const SizedBox(width: 6),
            _colorCircle(Colors.blue),
          ],
        )
      ],
    );
  }

  // -------------------- STYLE PREFERENCES --------------------

  Widget _buildStylePreferences() {
    final List<String> styles = [
      "Élégant",
      "Casual",
      "Sportif",
      "Bohème",
      "Minimaliste"
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Préférences de style",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

        const SizedBox(height: 15),

        Wrap(
          spacing: 8,
          children: styles
              .map((s) => Chip(
                    label: Text(s),
                    backgroundColor: Colors.pink.shade50,
                    labelStyle: const TextStyle(color: Colors.pink),
                  ))
              .toList(),
        ),

        const SizedBox(height: 15),

        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.grey),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text("+ Ajouter un style"),
        )
      ],
    );
  }

  // -------------------- RECOMMENDATIONS --------------------

  Widget _buildRecommendations() {
    final List recommendations = [
      {
        "title": "Style adapté à votre morphologie",
        "image":
            "https://images.unsplash.com/photo-1759754112225-8b7d43ea9716",
        "match": 95
      },
      {
        "title": "Basé sur vos préférences",
        "image":
            "https://images.unsplash.com/photo-1586024452802-86e0d084a4f9",
        "match": 92
      },
      {
        "title": "Tendance du moment",
        "image":
            "https://images.unsplash.com/photo-1632693217835-b482d9ca9ba0",
        "match": 88
      },
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Row(
                children: [
                  Icon(Icons.emoji_events, color: Colors.pink),
                  SizedBox(width: 8),
                  Text("Recommandations pour vous",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              Text("Voir tout", style: TextStyle(color: Colors.pink)),
            ],
          ),
        ),

        const SizedBox(height: 10),

        ...recommendations.map((rec) {
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.horizontal(left: Radius.circular(16)),
                  child: Image.network(rec["image"],
                      width: 90, height: 90, fit: BoxFit.cover),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(rec["title"]),
                    subtitle: Text("${rec["match"]}% compatible",
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey)),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  // -------------------- NOTIFICATIONS --------------------

  Widget _buildNotifications() {
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
                Text("Nouvelles tendances et looks",
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            )
          ],
        ),
        Switch(
          value: notificationsEnabled,
          activeColor: Colors.pink,
          onChanged: (v) {
            setState(() {
              notificationsEnabled = v;
            });
          },
        )
      ],
    );
  }

  // -------------------- MENU --------------------

  Widget _buildMenu() {
    final List<Map<String, dynamic>> menu = [
      {"label": "Historique des essayages", "icon": Icons.trending_up},
      {"label": "Paramètres du compte", "icon": Icons.settings},
      {"label": "Aide et support", "icon": Icons.help_outline},
    ];

    return Column(
      children: menu
          .map((item) => Column(
                children: [
                  ListTile(
                    leading: Icon(item["icon"] as IconData, color: Colors.grey),
                    title: Text(item["label"] as String),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                  const Divider(height: 1),
                ],
              ))
          .toList(),
    );
  }

  // -------------------- LOGOUT BUTTON --------------------

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 55,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text("Se déconnecter",
            style: TextStyle(color: Colors.red, fontSize: 16)),
      ),
    );
  }

  // -------------------- EDIT PROFILE MODAL --------------------

  void _openEditModal() {
    TextEditingController name = TextEditingController(text: "Marie Dubois");
    TextEditingController email =
        TextEditingController(text: "marie.dubois@email.com");

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(26)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom, top: 20, left: 16, right: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Modifier le profil",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                      onPressed: () {
                        Navigator.pop(context);
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

  // -------------------- SMALL COMPONENTS --------------------

  Widget _card({required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))
          ]),
      child: child,
    );
  }

  Widget _iconBtn(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white24, borderRadius: BorderRadius.circular(50)),
      child: Icon(icon, color: Colors.white),
    );
  }

  Widget _colorCircle(Color c) =>
      Container(width: 25, height: 25, decoration: BoxDecoration(color: c, shape: BoxShape.circle));

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

// -------------------- STATIC COMPONENTS --------------------

class _stat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _stat({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 22, color: Colors.white),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 18)),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}

Widget _titleRow(String title, String action) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      Text(action, style: const TextStyle(color: Colors.pink, fontSize: 14)),
    ],
  );
}