import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'screens/clothing_list_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/clothing_detail_screen.dart';
import 'screens/add_clothing_item.dart';
import 'screens/User_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Application de Vêtements',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginScreen(),debugShowCheckedModeBanner: false, 
      routes: {
        '/home': (context) => ClothingListScreen(),
        '/cart': (context) => CartScreen(userId: FirebaseAuth.instance.currentUser!.uid),
        '/add': (context) => AddClothingItemScreen(),
        '/details': (context) => ClothingDetailScreen(
              item: ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>,
            ),
        '/user': (context) => UserScreen(),
      },
    );
  }
}
