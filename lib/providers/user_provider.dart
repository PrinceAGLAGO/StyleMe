import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  Map<String, dynamic> _userData = {
    'nom': '',
    'email': '',
    'photoUrl': '',
    'morphologie': 'Standard',
    'stylePreferences': [],
    'taille': 170,
    'poids': 65,
    'couleurPeau': 'Moyenne',
    'notificationsEnabled': true,
  };

  List<String> _favoris = [];
  List<Map<String, dynamic>> _historiqueLooks = [];

  Map<String, dynamic> get userData => _userData;
  List<String> get favoris => _favoris;
  List<Map<String, dynamic>> get historiqueLooks => _historiqueLooks;

  void updateUserData(Map<String, dynamic> newData) {
    _userData.addAll(newData);
    notifyListeners();
  }

  void updateMorphologie(String morphologie) {
    _userData['morphologie'] = morphologie;
    notifyListeners();
  }

  void updateStylePreferences(List<String> preferences) {
    _userData['stylePreferences'] = preferences;
    notifyListeners();
  }

  void updateTaillePoids(int taille, int poids) {
    _userData['taille'] = taille;
    _userData['poids'] = poids;
    notifyListeners();
  }

  void updateCouleurPeau(String couleur) {
    _userData['couleurPeau'] = couleur;
    notifyListeners();
  }

  void toggleNotifications() {
    _userData['notificationsEnabled'] = !_userData['notificationsEnabled'];
    notifyListeners();
  }

  void addToFavoris(String lookId) {
    if (!_favoris.contains(lookId)) {
      _favoris.add(lookId);
      notifyListeners();
    }
  }

  void removeFromFavoris(String lookId) {
    _favoris.remove(lookId);
    notifyListeners();
  }

  bool isFavori(String lookId) {
    return _favoris.contains(lookId);
  }

  void addToHistorique(Map<String, dynamic> look) {
    _historiqueLooks.insert(0, {
      ...look,
      'date': DateTime.now().toIso8601String(),
    });
    
    if (_historiqueLooks.length > 50) {
      _historiqueLooks.removeLast();
    }
    
    notifyListeners();
  }

  void clearHistorique() {
    _historiqueLooks.clear();
    notifyListeners();
  }

  void setPhotoUrl(String photoUrl) {
    _userData['photoUrl'] = photoUrl;
    notifyListeners();
  }
}
