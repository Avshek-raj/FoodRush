import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/Screens/deliverto.dart';
import 'package:foodrush/Screens/editProfileUser.dart';
import 'package:foodrush/Screens/home_screen.dart';
import 'package:foodrush/Screens/payment.dart';
import 'package:foodrush/Screens/profile_screen.dart';
import 'package:foodrush/Screens/reviewPage.dart';
import 'package:foodrush/Screens/service/changePwService.dart';
import 'package:foodrush/login/changePwUI.dart';
import 'package:foodrush/login/signin_screen.dart';
import 'package:foodrush/providers/RestaurantProduct_provider.dart';
import 'package:foodrush/providers/cart_provider.dart';
import 'package:foodrush/Screens/Breakfast.dart';
import 'package:foodrush/Screens/ourMenu.dart';
import 'package:foodrush/login/signup_screen.dart';
import 'package:foodrush/providers/message_provider.dart';
import 'package:foodrush/providers/order_provider.dart';
import 'package:foodrush/providers/product_provider.dart';
import 'package:foodrush/providers/RestaurantProduct_provider.dart';
import 'package:foodrush/providers/restaurant_provider.dart';
import 'package:foodrush/providers/search_provider.dart';
import 'package:foodrush/providers/user_provider.dart';
import 'package:foodrush/providers/message_provider.dart';
import 'package:foodrush/controllerRestaurant.dart/notification.dart';
import 'package:foodrush/login/forgotPw1.dart';
import 'package:foodrush/login/forgotPw2.dart';
import 'package:foodrush/login/signup_screen.dart';
import 'package:foodrush/providers/product_provider.dart';
import 'package:foodrush/restaurantScreens/editFood.dart';
import 'package:foodrush/restaurantScreens/formLoginRestaurant.dart';
import 'package:foodrush/restaurantScreens/foodAdd.dart';
import 'package:foodrush/restaurantScreens/restaurantProfile.dart';
import 'package:foodrush/restaurantScreens/navbarRestaurant.dart';
import 'package:foodrush/restaurantScreens/EditProfileRestaurant.dart';
import 'package:foodrush/restaurantScreens/restaurantHome.dart';
import 'package:foodrush/restaurantScreens/settings.dart';
import 'package:foodrush/restaurantScreens/signupRestaurant.dart';
import 'package:provider/provider.dart';
import 'Screens/Navigation.dart';
import 'login/emailVerification_screen.dart';
import 'login/loginAs.dart';

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
          ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider(),
          ),
          ChangeNotifierProvider<SearchProvider>(
            create: (context) => SearchProvider(),
          ),
          ChangeNotifierProvider<RestaurantProvider>(
            create: (context) => RestaurantProvider(),
          ),
          ChangeNotifierProvider<RestaurantProductProvider>(
            create: (context) => RestaurantProductProvider(),
          ),
          ChangeNotifierProvider<MessageProvider>(
            create: (context) => MessageProvider(),
          ),
          ChangeNotifierProvider<OrderProvider>(
            create: (context) => OrderProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'Foodrush',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: LoginAs(),
        ));
  }
}
//samjhana12 password
