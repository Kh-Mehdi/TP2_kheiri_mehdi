class ClothingItem {
  final String image;
  final String titre;
  final String categorie; 
  final String taille;
  final String marque;
  final double prix;

  ClothingItem({
    required this.image,
    required this.titre,
    required this.categorie,
    required this.taille,
    required this.marque,
    required this.prix,
  });

  // Convertit un objet en Map pour Firestore
  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'titre': titre,
      'categorie': categorie,
      'taille': taille,
      'marque': marque,
      'prix': prix,
    };
  }

  // Crée un objet ClothingItem à partir d'une Map
  factory ClothingItem.fromMap(Map<String, dynamic> map) {
    return ClothingItem(
      image: map['image'] ?? '',
      titre: map['titre'] ?? '',
      categorie: map['categorie'] ?? '',
      taille: map['taille'] ?? '',
      marque: map['marque'] ?? '',
      prix: (map['prix'] ?? 0).toDouble(),
    );
  }
}
