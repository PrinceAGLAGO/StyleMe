import 'package:flutter/material.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  String selectedCategory = "Tout";

  List<String> categories = [
    "Tout",
    "Femme",
    "Homme",
    "Accessoires",
    "Chaussures",
    "Sacs",
  ];

  List<Map<String, dynamic>> trendingLooks = [
    {
      "id": 1,
      "image":
          "https://images.unsplash.com/photo-1656504450814-398cf348c038?auto=format&fit=crop&w=1080&q=80",
      "brand": "Zara",
      "title": "Look Urbain Chic",
      "likes": 2453,
      "influencer": "@emma_style",
    },
    {
      "id": 2,
      "image":
          "https://images.unsplash.com/photo-1632693217835-b482d9ca9ba0?auto=format&fit=crop&w=1080&q=80",
      "brand": "H&M",
      "title": "Street Style",
      "likes": 1892,
      "influencer": "@marie_fashion",
    },
    {
      "id": 3,
      "image":
          "https://images.unsplash.com/photo-1562182856-e39faab686d7?auto=format&fit=crop&w=1080&q=80",
      "brand": "Mango",
      "title": "Élégance Moderne",
      "likes": 3201,
      "influencer": "@julie_couture",
    },
    {
      "id": 4,
      "image":
          "https://images.unsplash.com/photo-1651083018668-33a9dc339579?auto=format&fit=crop&w=1080&q=80",
      "brand": "Pull&Bear",
      "title": "Casual Chic",
      "likes": 1567,
      "influencer": "@sarah_mode",
    },
    {
      "id": 5,
      "image":
          "https://images.unsplash.com/photo-1759754112225-8b7d43ea9716?auto=format&fit=crop&w=1080&q=80",
      "brand": "Bershka",
      "title": "Tendance 2024",
      "likes": 2891,
      "influencer": "@lisa_trends",
    },
    {
      "id": 6,
      "image":
          "https://images.unsplash.com/photo-1586024452802-86e0d084a4f9?auto=format&fit=crop&w=1080&q=80",
      "brand": "Stradivarius",
      "title": "Summer Vibes",
      "likes": 2104,
      "influencer": "@chloe_style",
    },
  ];

  List<int> liked = [];
  List<int> saved = [];

  void toggleLike(int id) {
    setState(() => liked.contains(id) ? liked.remove(id) : liked.add(id));
  }

  void toggleSave(int id) {
    setState(() => saved.contains(id) ? saved.remove(id) : saved.add(id));
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue.shade900,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Accueil',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            activeIcon: Icon(Icons.crop_free),
            label: 'Essayer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Favoris',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //  HEADER
            Container(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 25),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFF4F9A), Color(0xFF8B5CF6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "StyleMe",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            "Découvrez les tendances",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.trending_up,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 6),
                            Text(
                              "Trending",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // SEARCH BAR
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          size: 22,
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Rechercher un look, une marque...",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // CATEGORIES
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 0.3),
                ),
              ),
              child: SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (_, i) {
                    final cat = categories[i];
                    final selected = (cat == selectedCategory);

                    return GestureDetector(
                      onTap: () => setState(() => selectedCategory = cat),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: selected ? Colors.pink : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          cat,
                          style: TextStyle(
                            color: selected
                                ? Colors.white
                                : Colors.grey.shade800,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            //  SECTION POUR VOUS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Pour vous",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Voir tout",
                    style: TextStyle(
                      color: Colors.pink,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // 🖼️ GRID DES LOOKS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                itemCount: trendingLooks.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.70,
                ),
                itemBuilder: (_, i) {
                  final look = trendingLooks[i];
                  final isLiked = liked.contains(look["id"]);
                  final isSaved = saved.contains(look["id"]);

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // IMAGE + LIKE BTN
                        Expanded(
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(18),
                                ),
                                child: Image.network(
                                  look["image"],
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              Positioned(
                                top: 8,
                                right: 8,
                                child: GestureDetector(
                                  onTap: () => toggleLike(look["id"]),
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.8),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      isLiked
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isLiked
                                          ? Colors.pink
                                          : Colors.black87,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // INFO
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    look["brand"],
                                    style: const TextStyle(
                                      color: Colors.pink,
                                      fontSize: 11,
                                    ),
                                  ),
                                  Text(
                                    look["likes"].toString(),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 6),

                              Text(
                                look["title"],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),

                              const SizedBox(height: 3),

                              Text(
                                look["influencer"],
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ),

                              const SizedBox(height: 10),

                              Row(
                                children: [
                                  // SAVE
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () => toggleSave(look["id"]),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isSaved
                                              ? Colors.pink.shade100
                                              : Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              isSaved
                                                  ? Icons.bookmark
                                                  : Icons.bookmark_border,
                                              size: 16,
                                              color: isSaved
                                                  ? Colors.pink
                                                  : Colors.black87,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              "Sauver",
                                              style: TextStyle(
                                                color: isSaved
                                                    ? Colors.pink
                                                    : Colors.black87,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 8),

                                  // SHARE
                                  Container(
                                    width: 38,
                                    height: 38,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.share,
                                      size: 18,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
