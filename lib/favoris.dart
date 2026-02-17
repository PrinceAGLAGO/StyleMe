import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Favoris extends StatefulWidget {
  const Favoris({super.key});

  @override
  State<Favoris> createState() => _FavorisPageState();
}

class _FavorisPageState extends State<Favoris> {
  String viewMode = "grid"; 
  String activeTab = "collections"; 

  bool showNewCollection = false;
  final TextEditingController newCollectionController = TextEditingController();

  List<Map<String, dynamic>> collections = [
    {
      "id": 1,
      "name": "Soirée Chic",
      "items": 12,
      "thumbnail":
          "https://images.unsplash.com/photo-1562182856-e39faab686d7?q=80",
      "theme": "Élégant",
    },
    {
      "id": 2,
      "name": "Casual Weekend",
      "items": 8,
      "thumbnail":
          "https://images.unsplash.com/photo-1651083018668-33a9dc339579?q=80",
      "theme": "Décontracté",
    },
    {
      "id": 3,
      "name": "Bureau Pro",
      "items": 15,
      "thumbnail":
          "https://images.unsplash.com/photo-1656504450814-398cf348c038?q=80",
      "theme": "Professionnel",
    },
    {
      "id": 4,
      "name": "Summer Vibes",
      "items": 10,
      "thumbnail":
          "https://images.unsplash.com/photo-1586024452802-86e0d084a4f9?q=80",
      "theme": "Été",
    },
  ];

  List<Map<String, dynamic>> savedItems = [
    {
      "id": 1,
      "image":
          "https://images.unsplash.com/photo-1656504450814-398cf348c038?q=80",
      "title": "Look Urbain",
      "brand": "Zara",
    },
    {
      "id": 2,
      "image":
          "https://images.unsplash.com/photo-1632693217835-b482d9ca9ba0?q=80",
      "title": "Street Style",
      "brand": "H&M",
    },
    {
      "id": 3,
      "image": "https://images.unsplash.com/photo-1562182856-e39faab686d7?q=80",
      "title": "Robe Élégante",
      "brand": "Mango",
    },
    {
      "id": 4,
      "image":
          "https://images.unsplash.com/photo-1651083018668-33a9dc339579?q=80",
      "title": "Casual Chic",
      "brand": "Pull&Bear",
    },
  ];

  void createCollection() {
    String name = newCollectionController.text.trim();
    if (name.isNotEmpty) {
      setState(() {
        collections.add({
          "id": collections.length + 1,
          "name": name,
          "items": 0,
          "thumbnail":
              "https://via.placeholder.com/300x300.png?text=Nouvelle+Collection",
          "theme": "Personnalisé",
        });
        showNewCollection = false;
        newCollectionController.clear();
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Collection \"$name\" créée !")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,


      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 50,
              left: 16,
              right: 16,
              bottom: 20,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink, Colors.purple],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Mes Favoris",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Votre garde-robe numérique",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => setState(() => viewMode = "grid"),
                          icon: Icon(
                            Icons.grid_view,
                            color: viewMode == "grid"
                                ? Colors.white
                                : Colors.white60,
                          ),
                        ),
                        IconButton(
                          onPressed: () => setState(() => viewMode = "list"),
                          icon: Icon(
                            Icons.view_list,
                            color: viewMode == "list"
                                ? Colors.white
                                : Colors.white60,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

            
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => activeTab = "collections"),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: activeTab == "collections"
                                ? Colors.white
                                : Colors.white24,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Collections",
                              style: TextStyle(
                                color: activeTab == "collections"
                                    ? Colors.pink
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => activeTab = "items"),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: activeTab == "items"
                                ? Colors.white
                                : Colors.white24,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Tous les articles",
                              style: TextStyle(
                                color: activeTab == "items"
                                    ? Colors.pink
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),


          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: activeTab == "collections"
                  ? buildCollections()
                  : buildItems(),
            ),
          ),
        ],
      ),
    );
  }


  Widget buildCollections() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${collections.length} Collections",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
              onPressed: () {
                setState(() => showNewCollection = true);
                showCreateCollectionDialog();
              },
              icon: const Icon(Icons.add),
              label: const Text("Nouvelle"),
            ),
          ],
        ),
        const SizedBox(height: 10),

       
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: viewMode == "grid" ? 2 : 1,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: viewMode == "grid" ? 0.8 : 2.5,
            ),
            itemCount: collections.length,
            itemBuilder: (context, index) {
              final c = collections[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: c["thumbnail"],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            right: 10,
                            top: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "${c["items"]} articles",
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            c["name"],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.share, color: Colors.grey.shade600),
                        ],
                      ),
                    ),
                    Text(
                      c["theme"],
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }


  Widget buildItems() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${savedItems.length} Articles sauvegardés",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: const [
                Icon(Icons.create_new_folder, color: Colors.pink),
                SizedBox(width: 5),
                Text(
                  "Ajouter à",
                  style: TextStyle(color: Colors.pink, fontSize: 14),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 10),

        Expanded(
          child: GridView.builder(
            itemCount: savedItems.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: viewMode == "grid" ? 2 : 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: viewMode == "grid" ? 0.7 : 2.2,
            ),
            itemBuilder: (context, index) {
              final item = savedItems[index];

              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: item["image"],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          Positioned(
                            right: 10,
                            top: 10,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    savedItems.removeAt(index);
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            item["title"],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item["brand"],
                            style: const TextStyle(
                              color: Colors.pink,
                              fontSize: 12,
                            ),
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
      ],
    );
  }


  void showCreateCollectionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Créer une collection"),
        content: TextField(
          controller: newCollectionController,
          decoration: const InputDecoration(
            hintText: "Nom de la collection...",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Annuler"),
          ),
          ElevatedButton(
            onPressed: () {
              createCollection();
              Navigator.pop(context);
            },
            child: const Text("Créer"),
          ),
        ],
      ),
    );
  }
}