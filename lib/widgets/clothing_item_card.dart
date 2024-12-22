import 'package:flutter/material.dart';
import '../models/clothing_item.dart';
import '../screens/clothing_detail_screen.dart'; // Import de l'écran de détail

class ClothingItemCard extends StatelessWidget {
  final ClothingItem item;

  const ClothingItemCard({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigation vers ClothingDetailsScreen avec l'objet ClothingItem
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClothingDetailScreen(item: item.toMap()),
          ),
        );
      },
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: ListTile(
          leading: Image.network(
            item.image,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image, size: 60),
          ),
          title: Text(
            item.titre,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Catégorie: ${item.categorie}'),
              Text('Taille: ${item.taille}'),
              Text('Marque: ${item.marque}'),
              Text('Prix: ${item.prix.toStringAsFixed(2)} €'),
            ],
          ),
        ),
      ),
    );
  }
}
