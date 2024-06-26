import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/Screens/Navigation.dart';
import 'package:foodrush/Screens/home_screen.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../utils/color_utils.dart';

import 'package:foodrush/Screens/Navigation.dart';
import 'orderSummary_screen.dart';

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
  bool isLoading = true;
  late CartProvider cartProvider;
  late int grandTotal = 0;
  late List<int> itemCount = [];
  List<int> total = [];
  @override
  void initState() {
    CartProvider cartProvider = Provider.of(context, listen: false);
    cartProvider.fetchCartData((){
      if (cartProvider.cartList != null && cartProvider.cartList.isNotEmpty) {
        isLoading = false;
        grandTotal = cartProvider.calculateTotalPrice().toInt();
        for (var item in cartProvider.cartList) {
          itemCount.add(item.cartQuantity ?? 1);
          total = cartProvider.cartList.map((item) => int.parse(item.cartPrice ?? '0')).toList();
        }
      }
      isLoading = false;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of(context);
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            ):
          SafeArea(
        child: Column(
          children: [SingleChildScrollView(
        child: Column(
        children: [
          Row(
          children: [
       GestureDetector(
  onTap: () {
    // Navigate to the previous page
    Navigator.pop(context);
  },
  child: BackButton(
    color: Colors.black,
  ),
),
 //back jane button
        Spacer(),
        Text(
          "Your Order",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        Spacer(),
      
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 10),
        //   child: Container(
        //     height: 25,
        //     width: 25,
        //     decoration: BoxDecoration(
        //       shape: BoxShape.circle,
        //       color: Colors.white,
        //       border: Border.all(color: Colors.black),
        //     ),
        //     child: Icon(
        //       Icons.question_mark,
        //       color: Colors.black,
        //     ),
        //     alignment: Alignment.center,
        //   ),
        // ),
        ],
      ),
      SizedBox(
        height: 25,
      ),
      SizedBox(
          height: MediaQuery.of(context).size.height *0.55,
          width: MediaQuery.of(context).size.width * 0.89,
          child: cartProvider.cartList.length == 0 ?
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Your cart is Empty",
                    style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14)
                ),
              )
          :ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: cartProvider.cartList.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.fromLTRB(
                    0, 0, 0, 5),
                child:
                Container(
                  width: 370,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Set the main axis size to min
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 6, bottom: 0),
                            child: Text(cartProvider.cartList[index].restaurantName?? "", style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                              Spacer(),
                              GestureDetector(
                                onTap: (){
                                  cartProvider.deleteCartItem(cartProvider.cartList[index].cartId);
                                  setState(() {
                                    cartProvider.cartList.removeAt(index);
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only( top: 3, right: 3),
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
                                ),
                              )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
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
                            width: 95, // Adjust the width as needed
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
                                    if (itemCount[index] > 1) {
                                      setState(() {
                                        itemCount[index]--;
                                        grandTotal = grandTotal - int.parse(cartProvider.cartList[index].cartPrice!);
                                      total[index] = (int.parse(cartProvider.cartList[index].cartPrice!)*itemCount[index]);
                                      });
                                    }
                                  },
                                  icon: Icon(Icons.remove),
                                  iconSize: 10,
                                ),
                                Text(
                                  itemCount[index].toString(), // Counter value
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
                                    itemCount[index]++;
                                    grandTotal = grandTotal + int.parse(cartProvider.cartList[index].cartPrice!);
                                    total[index] = (int.parse(cartProvider.cartList[index].cartPrice!)*itemCount[index]);
                                    });

                                  },
                                  icon: Icon(Icons.add),
                                  iconSize: 10,
                                ),
                              ],
                            ),
                          ),

                          Spacer(),

                          // Padding(
                          //   padding: const EdgeInsets.only(right: 5, ),
                          //   child: Column(
                          //     children: [

                                Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Rs. " + (int.parse(cartProvider.cartList[index].cartPrice!)*itemCount[index]).toString(),
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                      ),
                                    )
                                ),
                          //     ],
                          //   )
                          // ),
                        ],
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
                            grandTotal.toString(),
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
                        foregroundColor: myColor, backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
                      },
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
                        foregroundColor: Colors.white, backgroundColor: myColor,
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => OrderSummary(
                          cartList: cartProvider.cartList, itemCount: itemCount, total: total, grandTotal: grandTotal,)
                        ));
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
