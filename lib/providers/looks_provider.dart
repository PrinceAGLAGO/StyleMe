import 'package:flutter/foundation.dart';

class LooksProvider with ChangeNotifier {
  List<Map<String, dynamic>> _trendingLooks = [
    {
      "id": "1",
      "image":
          "https://images.unsplash.com/photo-1656504450814-398cf348c038?auto=format&fit=crop&w=1080&q=80",
      "brand": "Zara",
      "title": "Look Urbain Chic",
      "likes": 2453,
      "influencer": "@emma_style",
      "category": "Femme",
      "tags": ["urbain", "chic", "moderne"],
    },
    {
      "id": "2",
      "image":
          "https://images.unsplash.com/photo-1632693217835-b482d9ca9ba0?auto=format&fit=crop&w=1080&q=80",
      "brand": "H&M",
      "title": "Street Style",
      "likes": 1892,
      "influencer": "@marie_fashion",
      "category": "Homme",
      "tags": ["street", "casual", "jeans"],
    },
    {
      "id": "3",
      "image":
          "https://images.unsplash.com/photo-1562182856-e39faab686d7?auto=format&fit=crop&w=1080&q=80",
      "brand": "Mango",
      "title": "Élégance Moderne",
      "likes": 3201,
      "influencer": "@julie_couture",
      "category": "Femme",
      "tags": ["élégant", "moderne", "soirée"],
    },
    {
      "id": "4",
      "image":
          "https://images.unsplash.com/photo-1572804013427-37d9098251f8?auto=format&fit=crop&w=1080&q=80",
      "brand": "Uniqlo",
      "title": "Minimaliste Chic",
      "likes": 1567,
      "influencer": "@leo_minimal",
      "category": "Homme",
      "tags": ["minimaliste", "basique", "qualité"],
    },
    {
      "id": "5",
      "image":
          "https://images.unsplash.com/photo-1558769132-cb1aea458c5e?auto=format&fit=crop&w=1080&q=80",
      "brand": "Zara",
      "title": "Bohème Style",
      "likes": 2890,
      "influencer": "@sophie_boho",
      "category": "Femme",
      "tags": ["bohème", "été", "décontracté"],
    },
    {
      "id": "6",
      "image":
          "https://images.unsplash.com/photo-1594633312681-425c7b97ccd1?auto=format&fit=crop&w=1080&q=80",
      "brand": "Nike",
      "title": "Sport Chic",
      "likes": 3421,
      "influencer": "@max_sport",
      "category": "Chaussures",
      "tags": ["sport", "chaussures", "tendance"],
    },
  ];

  String _selectedCategory = "Tout";
  List<String> _categories = [
    "Tout",
    "Femme",
    "Homme",
    "Accessoires",
    "Chaussures",
    "Sacs",
  ];

  List<Map<String, dynamic>> get trendingLooks => _trendingLooks;
  String get selectedCategory => _selectedCategory;
  List<String> get categories => _categories;

  List<Map<String, dynamic>> get filteredLooks {
    if (_selectedCategory == "Tout") {
      return _trendingLooks;
    }
    return _trendingLooks
        .where((look) => look["category"] == _selectedCategory)
        .toList();
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void incrementLikes(String lookId) {
    int index = _trendingLooks.indexWhere((look) => look["id"] == lookId);
    if (index != -1) {
      _trendingLooks[index]["likes"]++;
      notifyListeners();
    }
  }

  Map<String, dynamic>? getLookById(String id) {
    try {
      return _trendingLooks.firstWhere((look) => look["id"] == id);
    } catch (e) {
      return null;
    }
  }

  List<Map<String, dynamic>> searchLooks(String query) {
    if (query.isEmpty) return _trendingLooks;
    
    return _trendingLooks.where((look) {
      final title = look["title"].toString().toLowerCase();
      final brand = look["brand"].toString().toLowerCase();
      final influencer = look["influencer"].toString().toLowerCase();
      final tags = (look["tags"] as List<dynamic>)
          .map((tag) => tag.toString().toLowerCase())
          .join(" ");
      
      final searchQuery = query.toLowerCase();
      
      return title.contains(searchQuery) ||
             brand.contains(searchQuery) ||
             influencer.contains(searchQuery) ||
             tags.contains(searchQuery);
    }).toList();
  }

  List<Map<String, dynamic>> getLooksByCategory(String category) {
    return _trendingLooks
        .where((look) => look["category"] == category)
        .toList();
  }

  List<Map<String, dynamic>> getRecommendedLooks(List<String> preferences) {
    if (preferences.isEmpty) return _trendingLooks;
    
    return _trendingLooks.where((look) {
      final tags = (look["tags"] as List<dynamic>)
          .map((tag) => tag.toString().toLowerCase());
      
      return preferences.any((pref) => 
          tags.contains(pref.toLowerCase()) ||
          look["category"].toString().toLowerCase() == pref.toLowerCase()
      );
    }).toList();
  }
}
