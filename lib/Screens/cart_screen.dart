import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../utils/color_utils.dart';
import 'orderSummay_screen.dart';

class TopLiked {
  String? image, price, name;
  TopLiked({this.image, this.name, this.price});
}

 List<TopLiked> data = [];

class Cart extends StatefulWidget {
  Cart({super.key,String?  productName, String? productImage, int? productPrice, String? productDesc});
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  late CartProvider cartProvider;
  late int total = cartProvider.calculateTotalPrice().toInt();
  @override
  void initState() {
    CartProvider cartProvider = Provider.of(context, listen: false);
    cartProvider.fetchCartData();
    super.initState();
  }
  int itemCount = 1;
  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [SingleChildScrollView(
        child: Column(
        children: [
          Row(
          children: [
          BackButton(
          color: Colors.black,
        ), //back jane button
        Spacer(),
        Text(
          "Your Order",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: Colors.black),
            ),
            child: Icon(
              Icons.question_mark,
              color: Colors.black,
            ),
            alignment: Alignment.center,
          ),
        ),
        ],
      ),
      SizedBox(
        height: 25,
      ),
      //arko container for jollofRice
      SizedBox(
          height: MediaQuery.of(context).size.height *0.55,
          width: MediaQuery.of(context).size.width * 0.89,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount:
              cartProvider.cartList.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.fromLTRB(
                    0, 0, 0, 5),
                child:
                Container(
                  height: 85,
                  width: 370,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 65,
                        width: 65,
                        child: Container(
                          decoration: BoxDecoration(
                            // border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 82,
                          width: 82,
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Image.network(
                              cartProvider.cartList[index].cartImage.toString(),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.22,
                        child: Text(
                          cartProvider.cartList[index].cartName.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),

                      Spacer(),
                      //for counter
                      Container(
                        height: 25,
                        width: 88, // Adjust the width as needed
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                if (itemCount > 1) {
                                  setState(() {
                                  itemCount--;
                                  });
                                }
                              },
                              icon: Icon(Icons.remove),
                              iconSize: 10,
                            ),
                            Text(
                              itemCount.toString(), // Counter value
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                setState(() {
                                itemCount++;
                                });
                              },
                              icon: Icon(Icons.add),
                              iconSize: 10,
                            ),
                          ],
                        ),
                      ),

                      Spacer(),

                      Padding(
                        padding: const EdgeInsets.only(right: 5, ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: EdgeInsets.only(left: 40, top: 3),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end, // Align text to the right
                                  children: [
                                    Icon(
                                      Icons.close_sharp,
                                      color: Colors.grey,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              )

                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 11),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Rs. " + cartProvider.cartList[index].cartPrice.toString(),
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                )

                            ),
                          ],
                        )
                      ),
                    ],
                  ),
                ),
              ))),
            ],
          ),
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(10),
            ),
            height: MediaQuery.of(context).size.width*0.50,
            width: MediaQuery.of(context).size.width*0.96,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Total price",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            total.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            "(Delivery fee not included)",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                  width: 250,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        onPrimary: myColor,
                        primary: Colors.white,
                      ),
                      onPressed: () {},
                      child: Text("Add Items")),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: 250,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.white,
                        primary:myColor,
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => OrderSummary()));
                      },
                      child: Text("Checkout")),
                ),
              ],
            ),
          ),],
        ),

      ));
  }
}
