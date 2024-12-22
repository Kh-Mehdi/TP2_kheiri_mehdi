import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/clothing_item.dart';

class FirestoreService {
  final CollectionReference _clothingCollection =
      FirebaseFirestore.instance.collection('clothingItems');

  Future<List<ClothingItem>> fetchClothingItems() async {
    try {
      final QuerySnapshot snapshot = await _clothingCollection.get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return ClothingItem.fromMap(data);
      }).toList();
    } catch (e) {
      throw Exception('Erreur lors de la récupération des vêtements : $e');
    }
  }

  Future<void> addClothingItem(ClothingItem newItem) async {
    try {
      await _clothingCollection.add(newItem.toMap());
    } catch (e) {
      throw Exception('Erreur lors de l\'ajout d\'un vêtement : $e');
    }
  }
}
