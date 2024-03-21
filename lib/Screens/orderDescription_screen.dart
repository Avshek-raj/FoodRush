import 'dart:core';
import 'package:flutter/material.dart';

import '../providers/cart_provider.dart';
import '../reusable_widgets/reusable_widget.dart';
import '../utils/color_utils.dart';
import 'cart_screen.dart';

class OrderDescription extends StatefulWidget {
  String productName;
  String productImage;
  String productDesc;
  String productPrice;
  String productId;
  String restaurantName;
  String restaurantId;
  OrderDescription({super.key,required this.productId, required this.productName, required this.productImage, required this.productPrice, required this.productDesc, required this.restaurantName, required this.restaurantId});

  @override
  State<OrderDescription> createState() => _OrderDescriptionState();
}

class _OrderDescriptionState extends State<OrderDescription> {
  CartProvider cartProvider = CartProvider();
  int itemCount = 1;
  int index = 0; // Define the variable 'index'
  List<String> imageList = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6FDXEVGwbUXzSfr7lEHlf4uQjjkFQOHZkkg&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjVgzLDJZ96VN9FATx9F18wKKrwp3lbawRtg&s",
    "https://myhostplace.com/hulasfood_old/cp/img/uploads/45c48cce2e2d7fbdea1afc51c7c6ad26.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtUWqQzo9RuBSaqJDUQIUacI5seskQrqjNDd2LrGBKig&s",
    "https://www.spotlightnepal.com/media/images/Mnemonic_2.2e16d0ba.fill-650x500.jpg",
    //    "aset/images/carousel1.png",
    //   "aset/images/lactp2.png",
    //  "aset/images/food3.png",
    //  "aset/images/chocofun4.png",
    // "aset/images/momo5.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    BackButton(
                      color: Colors.black,
                    ),
                    Spacer(),
                    CartBadge(
                      itemCount: cartItemNumber ?? 0, // Replace this with
                    ),
                  ],
                ),
              ),
              //container for image
              Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                  // color: Colors.grey.shade300,
                  shape: BoxShape.rectangle,
                  // border: Border.all(color: Colors.grey.shade300),
                  // borderRadius: BorderRadius.circular(12),
                ),
                child: Image.network( widget.productImage,
                  height: 300,
                ),
              ),

              //container for description
              Container(
                width: 370,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.productName,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold, ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text(
                            "Rs: " + widget.productPrice,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold,color: myColor),
                          ),
                          Spacer(),
                          Container(
                            height: 30,
                            width: 118,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {

                                    if (itemCount > 1) {
                                      setState(() {
                                        itemCount--;
                                      });
                                    }
                                  },
                                  icon: Icon(Icons.remove), iconSize: 15,
                                ),
                                Text(
                                  itemCount.toString(), // Counter value
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    
                                    setState(() {
                                      itemCount++;
                                    });
                                  },
                                  icon: Icon(Icons.add), iconSize: 15,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          widget.productDesc,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 5),
                      //   child: Text(
                      //     "(Each serving contains 248 calories)",
                      //     style: TextStyle(
                      //         fontSize: 16,
                      //         color: Colors.red,
                      //         fontWeight: FontWeight.w300),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              //for carousel
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  // CarouselSlider(
                  //   options: CarouselOptions(
                  //     autoPlay: true,
                  //     enableInfiniteScroll: false,
                  //     enlargeCenterPage: true,
                  //     height: 200,
                  //   ),
                  //   items: imageList
                  //       .map(
                  //         (e) => ClipRRect(
                  //           borderRadius: BorderRadius.circular(6),
                  //           child: Stack(
                  //             fit: StackFit.expand,
                  //             children: [
                  //               Image.network(
                  //                 e,
                  //                 height: 200,
                  //                 width: 100,
                  //                 fit: BoxFit.cover,
                  //               ),
                  //               // Text(e)
                  //             ],
                  //           ),
                  //         ),
                  //         // {
                  //         //   // return Builder(
                  //         //   //   builder: (BuildContext context) {
                  //         //   //     return Container(
                  //         //   //       width: MediaQuery.of(context).size.width,
                  //         //   //       margin: EdgeInsets.symmetric(horizontal: 5.0),
                  //         //   //       decoration: BoxDecoration(color: Colors.amber),
                  //         //   //       // child: Text(
                  //         //   //       //   'text $i',
                  //         //   //       //   style: TextStyle(fontSize: 16.0),
                  //         //   //       // ),
                  //         //   //       child: Row(
                  //         //   //         children: [Text(data[index].image!)],
                  //         //   //       ),
                  //         //   //     );
                  //         //   //   },
                  //         //   // );
                  //         // }
                  //       )
                  //       .toList(),
                  // ),
                ],
              ),
              //container for total
              // Container(
              //   height: 150,
              //   width: 400,
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Colors.grey.shade300),
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
              //     child: Row(
              //       children: [
              //         Text(
              //           "Total:Rs200",
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold, fontSize: 17),
              //         ),
              //         Spacer(),
              //         Container(
              //           height: 50,
              //           width: 170,
              //           decoration: BoxDecoration(
              //               color:myColor,
              //               border: Border.all(color:myColor),
              //               borderRadius: BorderRadius.circular(10)),
              //           child: Row(
              //             children: [
              //               SizedBox(width: 15,),
              //               Icon(
              //                 Icons.shopping_cart,
              //                 color: Colors.white,
              //               ),
              //               SizedBox(width: 15,),
              //               Text(
              //                 "Add to cart",
              //                 style: TextStyle(
              //                     color: Colors.white,
              //                     fontWeight: FontWeight.bold),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border.all(color:Colors.white),
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          children: [
            Text(
              "Total: Rs. " + (int.parse(widget.productPrice) * itemCount).toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                cartProvider.addReviewCartData(context: context,
                  cartId: widget.productId,
                  cartImage: widget.productImage,
                  cartPrice: widget.productPrice,
                  cartName: widget.productName,
                  cartQuantity: itemCount,
                  restaurantName: widget.restaurantName,
                  restaurantId: widget.restaurantId,
                  onSuccess: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
                    // Execute any additional code on success
                  },
                  onError: (error) {
                    print('Failed to add product: $error');
                    // Execute any additional code on error
                  },
                  );
              },
              child: Container(
                height: 40,
                width: 170,
                decoration: BoxDecoration(
                    color:myColor,
                    border: Border.all(color:myColor),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    SizedBox(width: 15,),
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    SizedBox(width: 15,),
                    Text(
                      "Add to cart",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),

              ),
            )
          ],
        ),
      )
    );
  }
}

// class imageList {
//   String? image;
//   imageList({this.image});
// }