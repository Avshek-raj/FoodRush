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

import 'orderDescription_screen.dart';

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
            Center(child: Menus(menuName: "")),
            Center(child: Menus(menuName: "Snacks")),
            Center(child: Menus(menuName: "Breakfast")),
            Center(child: Menus(menuName: "Lunch")),
            Center(child: Menus(menuName: "Dinner")),
            Center(child:Menus(menuName: "Desserts") ),
            Center(child:Menus(menuName: "Beverage") ),
            Center(child: Menus(menuName: "Comboset")),
          ],
        ),
      ),
    );
  }
}

class Menus extends StatefulWidget {
  String? menuName;
  Menus({key, this.menuName}) : super(key: key);

  @override
  State<Menus> createState() => _MenusState();
}

class _MenusState extends State<Menus> {
  late ProductProvider productProvider;
  @override
  void initState() {
    ProductProvider productProvider = Provider.of(context, listen: false);
    if (widget.menuName == ""){
      productProvider.fetchFoodProductData();
    } else{
      productProvider.fetchMenuProducts(widget.menuName);
    }



    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            widget.menuName == ""?
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: productProvider.foodProductList.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) =>
                      OrderDescription(
                        productId:
                        productProvider
                            .foodProductList[
                        index]
                            .productId,
                        productName:
                        productProvider
                            .foodProductList[
                        index]
                            .productName,
                        productImage:
                        productProvider
                            .foodProductList[
                        index]
                            .productImage,
                        productPrice:
                        productProvider
                            .foodProductList[
                        index]
                            .productPrice,
                        productDesc:
                        productProvider
                            .foodProductList[
                        index]
                            .productDesc,
                        restaurantName: productProvider
                            .foodProductList[
                        index]
                            .restaurantName,
                        restaurantId: productProvider
                            .foodProductList[
                        index]
                            .restaurantId, role: 'user',
                      )));// Navigate to the order description screen
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 210,
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              child: Image.network(
                                productProvider.foodProductList[index].productImage!,
                                fit: BoxFit.fill,
                              ),
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
            ):
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: productProvider.menuProductList.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  OrderDescription(
                                    productId:
                                    productProvider
                                        .menuProductList[
                                    index]
                                        .productId,
                                    productName:
                                    productProvider
                                        .menuProductList[
                                    index]
                                        .productName,
                                    productImage:
                                    productProvider
                                        .menuProductList[
                                    index]
                                        .productImage,
                                    productPrice:
                                    productProvider
                                        .menuProductList[
                                    index]
                                        .productPrice,
                                    productDesc:
                                    productProvider
                                        .menuProductList[
                                    index]
                                        .productDesc,
                                    restaurantName: productProvider
                                        .menuProductList[
                                    index]
                                        .restaurantName,
                                    restaurantId: productProvider
                                        .menuProductList[
                                    index]
                                        .restaurantId, role: 'user',
                                  )));// Navigate to the order description screen
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 210,
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              child: Image.network(
                                productProvider.menuProductList[index].productImage!,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            child: Row(
                              children: [
                                Text(
                                  productProvider.menuProductList[index].productName!,
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
                                  "Rs. " + productProvider.menuProductList[index].productPrice!,
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
