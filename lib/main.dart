import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/Screens/home_screen.dart';
import 'package:foodrush/Screens/jpt.dart';
import 'package:foodrush/Screens/burger.dart';
import 'package:foodrush/Screens/ourMenu.dart';
import 'package:foodrush/Screens/tabbar.dart';
import 'package:foodrush/login/signup_screen.dart';
import 'package:foodrush/providers/product_provider.dart';
import 'package:foodrush/restaurantScreens/profile1.dart';
import 'package:foodrush/restaurantScreens/navbarRestaurant.dart';
import 'package:foodrush/restaurantScreens/profile2.dart';
import 'package:foodrush/restaurantScreens/settings.dart';
import 'package:foodrush/restaurantScreens/signupRestaurant.dart';
import 'package:provider/provider.dart';
import 'Screens/Navigation.dart';

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
    return ChangeNotifierProvider<ProductProvider>(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
    
          primarySwatch: Colors.red,

        ),
        home: ProfileRestaurant(),
      ),
    );
  }
}

