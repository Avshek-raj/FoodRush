import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/Screens/Chicken.dart';
import 'package:foodrush/Screens/Pizza.dart';
import 'package:foodrush/Screens/burger.dart';

class TabbarEg extends StatefulWidget {
  const TabbarEg({Key? key}) : super(key: key);

  @override
  _TabbarEgState createState() => _TabbarEgState();
}

class _TabbarEgState extends State<TabbarEg> {
  final List<Widget> _tabs = [
    Tab(text: 'Pizza'),
    Tab(text: 'Burger'),
    Tab(text: 'Chicken'),
    Tab(text: 'HotDog'),
    Tab(text: 'Yomari'),
    Tab(text: 'Sushi'),
    Tab(text: 'Noodles'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Our Menu',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Padding(
              padding: const EdgeInsets.only(left: 0.0), // Remove space here
              child: TabBar(
                isScrollable: true,
                tabs: _tabs,
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Pizza()),
            Center(child: Burger()),
            Center(child: Chicken()),
            Center(child: Text('HotDog content')),
            Center(child: Text('Yomari content')),
            Center(child: Text('Sushi content')),
            Center(child: Text('Noodles content')),
          ],
        ),
      ),
    );
  }
}
