import 'package:flutter/material.dart';
import 'package:foodrush/Screens/home_screen.dart';
import 'package:foodrush/Screens/profile_screen.dart';
import 'package:foodrush/restaurantScreens/foodAdd.dart';
import 'package:foodrush/restaurantScreens/profile1.dart';
import 'package:foodrush/restaurantScreens/restaurantHome_screen.dart';

class NavbarRestaurant extends StatefulWidget {
  const NavbarRestaurant({super.key});

  @override
  State<NavbarRestaurant> createState() => _NavbarRestaurantState();
}

class _NavbarRestaurantState extends State<NavbarRestaurant> {
  List<Widget> widgetList = [
    RestaurantHomeScreen(),
    AddFood(),
    AddFood(),
    ProfileRestaurant()
  ];
  int selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetList[selectedTab],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedTab,
          onTap: (value) {
            setState(() {
              selectedTab = value;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home",),
            BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: "Add Food"),
            BottomNavigationBarItem(icon: Icon(Icons.notifications_none_rounded), label: "Notification"),
            BottomNavigationBarItem(icon: Icon(Icons.person_outlined), label: "Profile"),
          ]),
    );
  }
}
