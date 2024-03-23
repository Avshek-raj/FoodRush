// import 'package:firebase1/util/string_const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/Screens/service/esewa.service.dart';
import 'package:foodrush/providers/message_provider.dart';
import 'package:foodrush/providers/restaurant_provider.dart';
import 'package:foodrush/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:foodrush/Screens/Navigation.dart';
import '../models/cart_model.dart';
import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';

// import 'package:text_divider/text_divider.dart';

class Payment extends StatefulWidget {
  String price;
  String productId;
  String productName;
  List<CartModel> cartList;
  Payment({super.key, required this.price, required this.productName, required this.productId, required this.cartList});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  late MessageProvider messageProvider;
  late CartProvider cartProvider;
  late UserProvider userProvider;
  late RestaurantProvider restaurantProvider;
  late OrderProvider orderProvider;
  bool selectedValue = true; // or whatever initial value you want

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of(context);
    messageProvider = Provider.of(context);
    userProvider = Provider.of(context);
    restaurantProvider =Provider.of(context);
    orderProvider =Provider.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  BackButton(
                    color: Colors.black,
                  ), //back jane button
                  Spacer(),
                  Text(
                    "Payment",
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
              SizedBox(
                height: 15,
              ),
              Text(
                "Choose your payment method",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: (){
                  Esewa esewa = Esewa(cartProvider);
                  esewa.pay(context, widget.price, widget.productId, widget.productName, widget.cartList);
                },
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset(
                    "assets/images/esewa.png",
                  ),
                ),
              ),
              Text(
                "eSewa",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              SizedBox(
                height: 15,
              ),
              // TextDivider.horizontal(
              //     text: const Text(
              //   'OR',
              //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              // )),
              Row(
    children: <Widget>[
        Expanded(
            child: Divider()
        ),       

        Text("OR"),        

        Expanded(
            child: Divider()
        ),
    ]
),
              SizedBox(
                height: 15,
              ),
              //container for cash on delivery
              Container(
                height: 90,
                width: 350,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Cash on delivery",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "(Pay with cash or POS on delivery)",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                          ]),
                      Spacer(),
                      Radio(
                        value: false, // value for the radio button
                        groupValue:
                            selectedValue, // selected value of the group
                        onChanged: (value) {
                          // handle onChanged event here
                          setState(() {
                            selectedValue=value!;
                          },);
                        },
                        activeColor: Colors.red,
                      ),

                      // Icon(Icons.circle,color: myColor,),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //Elevated button
              SizedBox(
                height: 50,
                width: 250,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.red,
                  ),
                  onPressed: () async{
                    int count = 0;
                    String sameRestaurantFoods = "";
                    String? oldRestaurantName;
                    // for (var item in widget.cartList){
                      widget.cartList.asMap().forEach((index, item) async {
                        String orderId = DateTime.now().millisecondsSinceEpoch.toString();
                        orderProvider.addOrderData(
                          orderId: orderId,
                          orderImage: item.cartImage,
                          userImage: userProvider.userModel.userImage?? "",
                          orderPrice: item.cartPrice,
                          orderName: item.cartName,
                          orderQuantity: item.cartQuantity,
                          userId: FirebaseAuth.instance.currentUser?.uid,
                          userName: userProvider.userModel.username,
                          userAddress: userProvider.deliveryInfoModel.address?? userProvider.userModel.address?? "",
                          restaurantId: item.restaurantId,
                          deliveryLatLng: userProvider.deliveryInfoModel.latLng,
                          payment: "Cash on delivery"
                        );
                        orderProvider.addOrderInHistory(
                            orderId: orderId,
                            orderImage: item.cartImage?? "",
                            orderPrice: item.cartPrice,
                            orderName: item.cartName,
                            orderQuantity: item.cartQuantity,
                            restaurantName: item.restaurantName,
                            restaurantId: item.restaurantId
                        );
                      cartProvider.deleteCartItem(item.cartId);
                      if (item.restaurantName == oldRestaurantName){
                        sameRestaurantFoods += ", ${item.cartQuantity} ${item.cartName} ";
                      } else {
                        if (sameRestaurantFoods != ""){
                          int lastCommaIndex = sameRestaurantFoods.lastIndexOf(',');
                          if (lastCommaIndex != -1) {
                            sameRestaurantFoods = sameRestaurantFoods.replaceRange(lastCommaIndex, lastCommaIndex + 1, ' and');
                          }
                          await restaurantProvider.fetchRestaurantDetails(widget.cartList[index-1].restaurantId, (result){
                            messageProvider.sendNotificationToUser(result.token,
                                "Order received from ${userProvider.userModel.username}",
                                "${sameRestaurantFoods} has been order",sameRestaurantFoods, userProvider.userModel);
                            });
                        }
                        sameRestaurantFoods = "";
                        oldRestaurantName = item.restaurantName;
                        sameRestaurantFoods = "${item.cartQuantity} ${item.cartName} ";

                      }
                      if (index == widget.cartList.length - 1){
                        int lastCommaIndex = sameRestaurantFoods.lastIndexOf(',');
                        if (lastCommaIndex != -1) {
                          sameRestaurantFoods = sameRestaurantFoods.replaceRange(lastCommaIndex, lastCommaIndex + 1, ' and');
                        }
                        restaurantProvider.fetchRestaurantToken(widget.cartList[index]!.restaurantId!,onSuccess: (){
                          messageProvider.sendNotificationToUser(restaurantProvider.token,
                              "Order received from ${userProvider.userModel.username}",
                              "${sameRestaurantFoods} has been order", sameRestaurantFoods, userProvider.userModel);
                        });
                      }
                      //if (count == widget.cartList.length - 1){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Center(child: Text("Order Successful")),
                              content: Column(
                                mainAxisSize: MainAxisSize.min, // To minimize the dialog size
                                children: [
                                  Image.asset(
                                    'assets/images/success.png',
                                    fit: BoxFit.fill,// Provide the correct asset path here
                                    width: 80, // Adjust the width as needed
                                    height: 80, // Adjust the height as needed
                                  SizedBox(height: 8),
                                  Text(
                                    "Your food has been ordered and will be delivered shortly by the restaurant.",
                                  ),
                                  SizedBox(height: 10,),
                                  Center(
                                    child: Text(
                                      "Thank you for ordering with us.",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("Close"),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen())); // Close dialog
                                  },
                                ),
                              ],
                            );
                          },
                        );
                    //  }
                      count++;
                    });

                  },
                  child: Text(
                    "Complete Order",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
