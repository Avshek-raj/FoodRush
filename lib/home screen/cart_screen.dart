import 'package:flutter/material.dart';

import '../utils/color_utils.dart';
import 'orderSummay_screen.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
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
                              "https://allaboutthecooks.co.uk/wp-content/uploads/2023/07/Oscar__R20.jpg",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Jollof Rice",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                        width: 14,
                      ),
                      Spacer(),
                      //for counter
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              // Decrease counter logic
                              int a = 0;
                              bool cartIncrease = false;

                              decreaseValue() {
                                if (a > 0) {
                                  a--;
                                }
                              }
                            },
                            icon: Icon(Icons.remove),
                          ),
                          Text(
                            "1", // Counter value
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: myColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // Increase counter logic
                              int a = 0;
                              bool cartIncrease = false;
                              increaseValue() {
                                a++;
                              }
                            },
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Icon(
                              Icons.close_sharp,
                              color: Colors.grey,
                              size: 18,
                            ),
                            Text(
                              "RS:200",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //container for spicy noodles
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
                              "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhFFCB6vec1NKDZ08tMd8AmcV0B97LZ5mhU4Q4out9v3D9dDgn-xD9-hprHTOElRr1PcqYoUFxQIt7znx2-tz40sLHTgCxNk62Vj0ieKuiD78U_1_PszT-2n1twQ4z0X7aEmFEWvGhV-bSkwQA1CdQhDIS9AYDEKl-gEFwxJMPmkTxWPKjOfRVS_SU1/s2006/Super_simple_noodle_recipe.jpg",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Spicy Noodles",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                        width: 14,
                      ),
                      //for counter
                      Spacer(),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              // Decrease counter logic
                            },
                            icon: Icon(Icons.remove),
                          ),
                          Text(
                            "1", // Counter value
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color:myColor),
                          ),
                          IconButton(
                            onPressed: () {
                              // Increase counter logic
                            },
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Icon(
                              Icons.close_sharp,
                              color: Colors.grey,
                              size: 18,
                            ),
                            Text(
                              "RS:400",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 300),
                //total price haru halne coontainer
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 258,
                  width: 378,
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
                                  "RS: 600",
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
                ),
              ],
            ),
          ),
        ));
  }
}