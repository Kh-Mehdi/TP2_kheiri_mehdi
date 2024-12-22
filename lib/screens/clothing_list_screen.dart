import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClothingListScreen extends StatefulWidget {
  @override
  _ClothingListScreenState createState() => _ClothingListScreenState();
}

class _ClothingListScreenState extends State<ClothingListScreen> {
  int _currentIndex = 0;

  // Cette fonction génère la page à afficher selon l'index
  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return _buildClothingList();
      default:
        return const Center(child: Text('Page non définie.'));
    }
  }

  // Fonction pour afficher la liste des vêtements en utilisant StreamBuilder
  Widget _buildClothingList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('clothes').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('Aucun vêtement disponible.'));
        }

        final clothes = snapshot.data!.docs;

        return ListView.builder(
          itemCount: clothes.length,
          itemBuilder: (context, index) {
            final item = clothes[index];
            final data = item.data() as Map<String, dynamic>;

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                leading: Image.network(
                  data['image'] ?? 'default_image_url', // Assurez-vous qu'il y a une image
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(data['titre'] ?? 'Titre indisponible'), // Utilisation de 'titre' et 'default' si null
                subtitle: Text(
                  'Catégorie : ${data['categorie'] ?? 'Non spécifié'} - Taille : ${data['taille'] ?? 'Non spécifiée'} - Prix : ${data['prix'] ?? 'Non disponible'} € - Marque : ${data['marque'] ?? 'Non spécifiée'}',
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/details',
                    arguments: data, // Envoie les données du vêtement dans les arguments
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentIndex == 0
            ? 'Acheter des vêtements'
            : _currentIndex == 1
                ? 'Mon Panier'
                : 'Mon Profil'),
      ),
      body: _buildPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/cart'); // Redirige vers la page du panier
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Acheter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Panier',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
