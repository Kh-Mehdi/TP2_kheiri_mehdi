import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tp2/services/ajouter_service.dart';

class AddClothingItemScreen extends StatefulWidget {
  @override
  _AddClothingItemScreenState createState() => _AddClothingItemScreenState();
}

class _AddClothingItemScreenState extends State<AddClothingItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ajouterService = AjouterService();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  File? _imageFile;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveClothingItem() async {
    if (!_formKey.currentState!.validate() || _imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tous les champs sont obligatoires, y compris l\'image.'),
        ),
      );
      return;
    }

    try {
      // Simule l'URL de l'image pour cet exemple (ajoutez ici un service de stockage si nécessaire)
      String imageUrl = 'https://example.com/image.jpg';

      await _ajouterService.saveClothingItem(
        titre: _titleController.text,
        categorie: _categoryController.text,
        taille: _sizeController.text,
        marque: _brandController.text,
        prix: double.parse(_priceController.text),
        image: imageUrl,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vêtement ajouté avec succès !')),
      );

      // Réinitialise le formulaire
      _formKey.currentState!.reset();
      setState(() {
        _imageFile = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur : $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter un vêtement')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Titre'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Ce champ est obligatoire'
                      : null,
                ),
                TextFormField(
                  controller: _categoryController,
                  decoration: const InputDecoration(
                      labelText: 'Catégorie (ex: Pantalon, T-shirt)'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Ce champ est obligatoire'
                      : null,
                ),
                TextFormField(
                  controller: _sizeController,
                  decoration: const InputDecoration(labelText: 'Taille'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Ce champ est obligatoire'
                      : null,
                ),
                TextFormField(
                  controller: _brandController,
                  decoration: const InputDecoration(labelText: 'Marque'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Ce champ est obligatoire'
                      : null,
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(labelText: 'Prix'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null ||
                          double.tryParse(value) == null
                      ? 'Veuillez entrer un prix valide'
                      : null,
                ),
                const SizedBox(height: 20),
                _imageFile == null
                    ? const Text('Aucune image sélectionnée.')
                    : Image.file(_imageFile!, height: 100),
                TextButton.icon(
                  icon: const Icon(Icons.image),
                  label: const Text('Choisir une image'),
                  onPressed: _pickImage,
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _saveClothingItem,
                    child: const Text('Ajouter'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
