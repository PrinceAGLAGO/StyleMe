import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';

class Essayer extends StatefulWidget {
  const Essayer({super.key});

  @override
  State<Essayer> createState() => _EssayerState();
}

class _EssayerState extends State<Essayer> {
  String? _userPhotoUrl;
  int? _selectedItem;
  Color _selectedColor = Colors.white;
  String _activeTab = 'clothes';
  final List<String> _savedLooks = [];
  final ImagePicker _picker = ImagePicker();
  String? _selectedClothingName;
  String? _selectedClothingCategory;

  final List<Map<String, dynamic>> clothingItems = [
    {
      'id': 1,
      'name': 'T-shirt Blanc',
      'category': 'Haut',
      'colors': [Colors.white, Colors.black, const Color(0xFFFF6B9D)],
      'image': 'https://images.unsplash.com/photo-1521572163464-794f78e4c5e4',
    },
    {
      'id': 2,
      'name': 'Jean Slim',
      'category': 'Bas',
      'colors': [
        const Color(0xFF1E3A8A),
        Colors.black,
        const Color(0xFF6B7280),
      ],
      'image': 'https://images.unsplash.com/photo-1542272604-787c3835535d',
    },
    {
      'id': 3,
      'name': 'Veste Cuir',
      'category': 'Veste',
      'colors': [
        Colors.black,
        const Color(0xFF8B4513),
        const Color(0xFF4B5563),
      ],
      'image': 'https://images.unsplash.com/photo-1551698618-1dfe5d97d256',
    },
  ];

  final List<Map<String, dynamic>> accessories = [
    {
      'id': 5, 
      'name': 'Chapeau', 
      'category': 'Accessoire',
      'image': 'https://images.unsplash.com/photo-1521312208118-0ecbae4e3b6c',
    },
    {
      'id': 6, 
      'name': 'Lunettes', 
      'category': 'Accessoire',
      'image': 'https://images.unsplash.com/photo-1511499767150-a48a237f0078',
    },
    {
      'id': 7, 
      'name': 'Collier', 
      'category': 'Accessoire',
      'image': 'https://images.unsplash.com/photo-1599643478518-4e89a8dcf458',
    },
  ];

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        // Sur Flutter Web, on utilise une URL temporaire
        if (kIsWeb) {
          _userPhotoUrl = image.path;
        } else {
          _userPhotoUrl = image.path;
        }
      });
    }
  }

  void _saveLook() {
    if (_userPhotoUrl != null) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      
      // Récupérer les informations de l'item sélectionné
      Map<String, dynamic>? selectedItemData;
      if (_selectedItem != null) {
        selectedItemData = [...clothingItems, ...accessories]
            .firstWhere((item) => item['id'] == _selectedItem);
      }
      
      final lookData = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'title': 'Look du ${DateTime.now().day}/${DateTime.now().month}',
        'date': DateTime.now().toString().split(' ')[0],
        'userImage': _userPhotoUrl,
        'clothingItem': selectedItemData,
        'selectedColor': _selectedColor.value.toString(),
        'timestamp': DateTime.now().toIso8601String(),
      };
      
      userProvider.addToHistorique(lookData);
      
      setState(() {
        _savedLooks.add(_userPhotoUrl!);
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 8),
              Text('Look sauvegardé dans votre historique !'),
            ],
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: 'Voir',
            textColor: Colors.white,
            onPressed: () {
              // Naviguer vers l'onglet Profil pour voir l'historique
              _navigateToProfil();
            },
          ),
        ),
      );
    }
  }

  void _navigateToProfil() {
    // Naviguer vers l'onglet Profil (index 3)
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const NavigationRoot(initialIndex: 3),
      ),
      (route) => false,
    );
  }

  void _resetTryOn() {
    setState(() {
      _userPhotoUrl = null;
      _selectedItem = null;
      _selectedClothingName = null;
      _selectedClothingCategory = null;
      _selectedColor = Colors.white;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Essayage Virtuel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Testez votre look en AR',
                    style: TextStyle(
                      color: Colors.purple.shade100,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 3 / 4,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFFF3F4F6),
                                    Color(0xFFE5E7EB),
                                  ],
                                ),
                              ),
                              child: _userPhotoUrl != null
                                  ? Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                top: Radius.circular(20),
                                              ),
                                          child: _buildImage(_userPhotoUrl!),
                                        ),
                                        if (_selectedItem != null && _selectedClothingName != null)
                                          Positioned(
                                            top: 20,
                                            right: 20,
                                            child: Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(0.7),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    _selectedClothingName!,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  Text(
                                                    _selectedClothingCategory ?? '',
                                                    style: const TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        if (_selectedItem != null)
                                          Positioned.fill(
                                            child: Center(
                                              child: Container(
                                                width: 180,
                                                height: 180,
                                                decoration: BoxDecoration(
                                                  color: _selectedColor
                                                      .withOpacity(0.3),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                    color: _selectedColor,
                                                    width: 2,
                                                  ),
                                                ),
                                                child: Icon(
                                                  Icons.check_circle_outline,
                                                  color: _selectedColor,
                                                  size: 40,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    )
                                  : const Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.camera_alt,
                                            size: 48,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(height: 16),
                                          Text(
                                            'Capturez votre photo',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            'ou importez une image',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () =>
                                        _pickImage(ImageSource.camera),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFDB2777),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    icon: const Icon(
                                      Icons.camera_alt,
                                      size: 20,
                                    ),
                                    label: const Text('Caméra'),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () =>
                                        _pickImage(ImageSource.gallery),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF7C3AED),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    icon: const Icon(Icons.upload, size: 20),
                                    label: const Text('Importer'),
                                  ),
                                ),
                                if (_userPhotoUrl != null) ...[
                                  const SizedBox(width: 8),
                                  SizedBox(
                                    width: 50,
                                    child: ElevatedButton(
                                      onPressed: _resetTryOn,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey.shade200,
                                        foregroundColor: Colors.grey.shade800,
                                        padding: const EdgeInsets.all(12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.refresh,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _activeTab = 'clothes'),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: _activeTab == 'clothes'
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: _activeTab == 'clothes'
                                      ? [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            blurRadius: 2,
                                            offset: const Offset(0, 1),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: const Text(
                                  'Vêtements',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF4B5563),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _activeTab = 'accessories'),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: _activeTab == 'accessories'
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: _activeTab == 'accessories'
                                      ? [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            blurRadius: 2,
                                            offset: const Offset(0, 1),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: const Text(
                                  'Accessoires',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF4B5563),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _activeTab == 'clothes'
                        ? _buildClothingItems()
                        : _buildAccessories(),
                    const SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: _userPhotoUrl != null && _selectedItem != null
          ? Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _saveLook,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEC4899),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.download, size: 20),
                        label: const Text('Sauvegarder'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Fonctionnalité de partage bientôt disponible!")),
                          );
                        },
                        icon: const Icon(Icons.share, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildImage(String imagePath) {
    if (kIsWeb) {
      // Pour Flutter Web, on utilise Image.network avec une URL data ou un fichier temporaire
      if (imagePath.startsWith('http')) {
        return Image.network(
          imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red),
                  SizedBox(height: 8),
                  Text("Erreur de chargement", style: TextStyle(color: Colors.red)),
                ],
              ),
            );
          },
        );
      } else {
        // Pour les fichiers locaux sur Web, on utilise une approche différente
        return Image.asset(
          'assets/placeholder.png', // Image placeholder
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(Icons.image, size: 100, color: Colors.grey),
            );
          },
        );
      }
    } else {
      // Pour mobile/desktop
      return Image.file(
        File(imagePath),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.red),
                SizedBox(height: 8),
                Text("Erreur de chargement", style: TextStyle(color: Colors.red)),
              ],
            ),
          );
        },
      );
    }
  }

  Widget _buildClothingItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Sélectionnez un vêtement',
            style: TextStyle(color: Color(0xFF6B7280), fontSize: 14),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: clothingItems.length,
          itemBuilder: (context, index) {
            final item = clothingItems[index];
            final isSelected = _selectedItem == item['id'];
            
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: isSelected
                    ? Border.all(color: const Color(0xFFEC4899), width: 2)
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedItem = item['id'] as int;
                      _selectedColor = (item['colors'] as List<Color>).first;
                      _selectedClothingName = item['name'];
                      _selectedClothingCategory = item['category'];
                    });
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Image du vêtement
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            item['image'],
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 80,
                                height: 80,
                                color: Colors.grey[200],
                                child: const Icon(Icons.image, color: Colors.grey),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['category'],
                                style: const TextStyle(
                                  color: Color(0xFF6B7280),
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.straighten,
                                    size: 16,
                                    color: Color(0xFF9CA3AF),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Text(
                                      'S',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEC4899),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAccessories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Ajoutez des accessoires',
            style: TextStyle(color: Color(0xFF6B7280), fontSize: 14),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: accessories.length,
          itemBuilder: (context, index) {
            final item = accessories[index];
            final isSelected = _selectedItem == item['id'];
            
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: isSelected
                    ? Border.all(color: const Color(0xFFEC4899), width: 2)
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedItem = item['id'] as int;
                      _selectedClothingName = item['name'];
                      _selectedClothingCategory = item['category'];
                    });
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Image de l'accessoire
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            item['image'],
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 80,
                                height: 80,
                                color: Colors.grey[200],
                                child: const Icon(Icons.image, color: Colors.grey),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['category'],
                                style: const TextStyle(
                                  color: Color(0xFF6B7280),
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEC4899),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

// Import pour NavigationRoot
import 'navigation_root.dart';
