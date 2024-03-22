import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodrush/Screens/deliverto.dart';
import 'package:foodrush/Screens/payment.dart';
import 'package:foodrush/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';
import '../utils/color_utils.dart';

class OrderSummary extends StatefulWidget {
  List<CartModel> cartList ;
  List<int> itemCount ;
  List<int> total ;
  int grandTotal ;
  OrderSummary({super.key,required this.cartList, required this.itemCount, required this.total, required this.grandTotal});

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  @override
  Widget build(BuildContext context) {
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
                    "Order Summary",
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
                height: MediaQuery.of(context).size.height*0.52,
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
                        height: MediaQuery.of(context).size.height*0.3,
                        child: ListView.builder(
                            shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: widget.cartList.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.fromLTRB(
                            0, 0, 0, 5),
                          child: Column(
                            children: [
                              Align(
                                alignment:Alignment.centerLeft ,
                                  child: Text(widget.cartList[index].restaurantName?? "", style: TextStyle(fontWeight: FontWeight.bold),)),
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
                                      widget.cartList[index].cartImage!,
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
                                          widget.cartList[index].cartName.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          widget.cartList[index].cartPrice.toString() + "*" + widget.cartList[index].cartQuantity.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        )
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "Rs. " + (int.parse(widget.cartList[index].cartPrice!)*widget.cartList[index].cartQuantity!).toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600, fontSize: 18),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          )
                        ),
                      ),

                      Divider(),
                      //sub total
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sub total:",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              SizedBox(height: 15,),
                              Text(
                                "Delivery fee:",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              SizedBox(height: 15,),
                              Text(
                                "Total Amount:",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 18),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 139),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Rs. " + widget.grandTotal.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600, fontSize: 18),
                                ),
                                SizedBox(height: 15,),
                                Text(
                                  "RS: 50",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600, fontSize: 18),
                                ),
                                SizedBox(height: 15,),
                                Text(
                                  "Rs. " + (widget.grandTotal + 50).toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700, fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //delivery address ko container
              Container(
                width: 350,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Row(
                      children: [
                        Text(
                          "Delivery Address",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    //column for name
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name:",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                            Text(
                              "Address:",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                            Text(
                              "Landmark:",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                            Text(
                              "Phone:",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                          ],
                        ),
//column for value
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userProvider.deliveryInfoModel.name?? userProvider.userModel.username??"xxxxx xxxxx",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                              Text(
                                userProvider.deliveryInfoModel.address??userProvider.userModel.address??"xxxxx, xxxxx",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                              Text(
                                userProvider.deliveryInfoModel.landmark??"xxxxx",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                              Text(
                                userProvider.deliveryInfoModel.phone??userProvider.userModel.phone??"xxxxxxxxxx",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> DeliverTo()));
                        }, icon: Icon(Icons.edit,)
                        )
                      ],
                    ),
                  ]),
                ),
              ),
              //button halne container
              Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: 250,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: myColor, backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Edit Order",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: 250,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: myColor,
                            ),
                            onPressed: () {
                              String productName = "";
                              String productId = "";
                              for (var item in widget.cartList) {
                                productName += item.cartName! + ",";
                                productId += item.cartId! + ",";
                              }
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Payment( price: widget.grandTotal.toString(), productId: productId, productName: productName,cartList: widget.cartList)));
                            },
                            child: Text(
                              "Proceed to payment",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            )),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      //),
    );
  }
}