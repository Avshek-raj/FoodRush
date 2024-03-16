import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/Screens/Chicken.dart';
import 'package:foodrush/Screens/Pizza.dart';
import 'package:foodrush/Screens/burger.dart';
import 'package:foodrush/providers/product_provider.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import 'orderDescription_screen.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final List<Widget> _tabs = [
    Tab(text: 'All'),
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
          title:
          Center(
            child: Text(
              'Our Menu',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          bottom:
    PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),

              child: Container(
                padding: const EdgeInsets.only(left: 0.0),
                child: Transform.translate(offset: Offset(-29,0),
                child: TabBar(
                  padding: EdgeInsets.only(left: 0),
                  isScrollable: true,
                  tabs: _tabs,
                  indicatorColor: Colors.red,
                ),
              ),
        )
            ),
         //),
        ),
        body: TabBarView(
          children: [
            Center(child: Menus()),
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

class Menus extends StatefulWidget {
  Menus({super.key});

  @override
  State<Menus> createState() => SidesState();
}


class SidesState extends State<Menus> {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(

      body:  SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: productProvider.foodProductList.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: GestureDetector(
                    onTap: (){
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
                                        .restaurantId,
                                  )));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                          Border.all(color: Colors.grey.shade400),
                          borderRadius:
                          BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12)),
                            child: Image.network(
                              productProvider.foodProductList[index].productImage!,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 10),
                            child: Row(
                              children: [
                                Text(productProvider.foodProductList[index].productName!,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight:
                                        FontWeight.bold,
                                        fontSize: 16)),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Text(
                                  "Rs. " + productProvider.foodProductList[index].productPrice!,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 16),
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
