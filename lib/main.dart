import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/Screens/home_screen.dart';
import 'package:foodrush/login/signin_screen.dart';
import 'package:foodrush/providers/cart_provider.dart';
import 'package:foodrush/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'Screens/mainScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: MainScreen(),
      ),
    );
  }
}

