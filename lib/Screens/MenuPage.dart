import 'package:flutter/material.dart';
import 'package:foodrush/Screens/Beverage.dart';
import 'package:foodrush/Screens/ComboSet.dart';
import 'package:foodrush/Screens/Dessert.dart';
import 'package:foodrush/Screens/Dinner.dart';
import 'package:foodrush/Screens/Lunch.dart';
import 'package:foodrush/Screens/Snacks.dart';
import 'package:foodrush/Screens/Breakfast.dart';
import 'package:foodrush/providers/product_provider.dart';
import 'package:provider/provider.dart';

class Menu extends StatefulWidget {
  final int initialTabIndex; // Index of the tab to be initially selected
  const Menu({Key? key, required this.initialTabIndex}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final List<String> _tabNames = [
    'All',
    'Snacks',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Desserts',
    'Beverage',
    'Combo Set',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabNames.length,
      initialIndex: widget.initialTabIndex,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Our Menu',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              padding: const EdgeInsets.only(left: 0.0),
              child: Transform.translate(
                offset: Offset(-29, 0),
                child: TabBar(
                  padding: EdgeInsets.only(left: 0),
                  isScrollable: true,
                  tabs: _tabNames.map((name) => Tab(text: name)).toList(),
                  indicatorColor: Colors.red,
                  labelColor: Colors.red, // This sets the color of the selected tab text
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Menus()),
            Center(child: Snacks()),
            Center(child: Breakfast()),
            Center(child: Lunch()),
            Center(child: Dinner()),
            Center(child:Dessert() ),
            Center(child:Beverage() ),
            Center(child: ComboSet()),
          ],
        ),
      ),
    );
  }
}

class Menus extends StatefulWidget {
  Menus({Key? key}) : super(key: key);

  @override
  State<Menus> createState() => _MenusState();
}

class _MenusState extends State<Menus> {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: productProvider.foodProductList.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to the order description screen
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: Image.network(
                              productProvider.foodProductList[index].productImage!,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            child: Row(
                              children: [
                                Text(
                                  productProvider.foodProductList[index].productName!,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Text(
                                  "Rs. " + productProvider.foodProductList[index].productPrice!,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
