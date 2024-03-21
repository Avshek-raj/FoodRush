import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/Screens/profile_screen.dart';
import 'package:foodrush/Screens/search_screen.dart';
import 'MenuPage.dart';
import 'cart_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  int? page;
  MainScreen({super.key, this.page});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    Search(),
    Menu(initialTabIndex: 0,),
    Cart(),
    ProfileScreen(),
  ];
  int selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    if (widget.page != null){
      selectedTab = widget.page!;
      widget.page = null;
    }
    return Scaffold(
      body: _pages[selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Ensure all items are visible
        iconSize: 30,
        currentIndex: selectedTab,
        onTap: (index) {
          setState(() {
            selectedTab = index;
          });
        },
          selectedItemColor: Colors.red,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Menus',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page Two'),
    );
  }
}

class PageThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page Two'),
    );
  }
}
class PageFour extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page Two'),
    );
  }
}

