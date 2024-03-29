import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodrush/Screens/reviewPage.dart';
import 'package:provider/provider.dart';

import '../models/cart_model.dart';
import '../providers/cart_provider.dart';
import '../providers/user_provider.dart';

class OrderHistory extends StatefulWidget {
  List<CartModel>? cartList;
  List<int>? itemCount;
  List<int>? total;
  int? grandTotal;
  OrderHistory({Key? key, this.cartList, this.itemCount, this.total, this.grandTotal}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  bool isLoading =true;
  late CartProvider cartProvider;

  @override
  void initState() {
    super.initState();
    cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.fetchHistoryData(() {
      setState(() {
        isLoading = false;
      });
      ;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      ):SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                BackButton(
                  color: Colors.black,
                ),
                Spacer(),
                Text(
                  "Order History",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
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
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order details",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: cartProvider.historyList.length,
                          itemBuilder: (context, index) => Container(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      cartProvider.historyList[index].restaurantName ?? "",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(color: Colors.grey.shade200),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
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
                                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                                            ),
                                            Text(
                                              cartProvider.historyList[index].cartPrice.toString() +
                                                  "*" +
                                                  cartProvider.historyList[index].cartQuantity.toString(),
                                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                                            )
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "Rs. " +
                                            (int.parse(cartProvider.historyList[index].cartPrice!) *
                                                cartProvider.historyList[index].cartQuantity!).toString(),
                                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                                      ),

                                    ],
                                  ),
GestureDetector(
  onTap: () {
    // Navigate to the other page when text is tapped
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => reviewPage(orderModal: cartProvider.historyList[index])),
    );
  },
  child: Text(
    "Write Review",
    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
  ),
),
                                ],
                              ),
                            ),
                          ),
                        ), //sub total
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
