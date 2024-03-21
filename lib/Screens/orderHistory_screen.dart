import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart_model.dart';
import '../providers/cart_provider.dart';
import '../providers/user_provider.dart';

class OrderHistory extends StatefulWidget {
  List<CartModel>? cartList ;
  List<int>? itemCount ;
  List<int>? total ;
  int? grandTotal ;
  OrderHistory({super.key, this.cartList,  this.itemCount,  this.total,  this.grandTotal});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  late CartProvider cartProvider;
  void initState() {
    CartProvider cartProvider = Provider.of(context, listen: false);
    cartProvider.fetchHistoryData((){
    });
  }
  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body:
      // SingleChildScrollView(
      // child:
      SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                BackButton(
                  color: Colors.black,
                ), //back jane button
                Spacer(),
                Text(
                  "Order History",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
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
            //Container1
            Container(
              width: 350,
              decoration: BoxDecoration(
                // shape: BoxShape.rectangle,
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order details",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: cartProvider.historyList.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.fromLTRB(
                                0, 0, 0, 5),
                            child: Column(
                              children: [
                                Align(
                                    alignment:Alignment.centerLeft ,
                                    child: Text(cartProvider.historyList[index].restaurantName?? "", style: TextStyle(fontWeight: FontWeight.bold),)),
                                Row(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        // shape: BoxShape.rectangle,
                                          color: Colors.white,
                                          border: Border.all(color: Colors.grey.shade200),
                                          borderRadius: BorderRadius.circular(10)),
                                      child: Image.network(
                                        cartProvider.historyList[index].cartImage!,
                                        height: 40,
                                        width: 40,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cartProvider.historyList[index].cartName.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            cartProvider.historyList[index].cartPrice.toString() + "*" + cartProvider.historyList[index].cartQuantity.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18),
                                          )
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "Rs. " + (int.parse(cartProvider.historyList[index].cartPrice!)*cartProvider.historyList[index].cartQuantity!).toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600, fontSize: 18),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                      ),
                    ), //sub total

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      //),
    );
  }
}
