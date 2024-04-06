import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/restaurantScreens/restaurantHome.dart';
import 'package:foodrush/restaurantScreens/userDetails_screen.dart';
import 'package:provider/provider.dart';

import '../providers/order_provider.dart';
import '../reusable_widgets/reusable_widget.dart';

class OrderRequests extends StatefulWidget {
  OrderRequests({Key? key}) : super(key: key);

  @override
  State<OrderRequests> createState() => _OrderRequestsState();
}

class _OrderRequestsState extends State<OrderRequests> {
  late OrderProvider orderProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      orderProvider = Provider.of(context, listen: false);
      orderProvider.fetchOrderData(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    orderProvider = Provider.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeRestaurant()),
                      );
                    },
                    child: BackButton(
                      color: Colors.black,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Order requests",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.93,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade500),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child:
                  orderProvider.cartList.isEmpty
                      ? Center(
                    child: Text(
                      "You don't have any orders currently",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  )
                      :
                  ListView.builder(
                    itemCount: orderProvider.cartList.length == 0? 1:  orderProvider.cartList.length ,
                    itemBuilder: (context, index) {
                      if (orderProvider.cartList.length == 0){
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 100),
                          child: Center(
                            child: Text(
                              "You don't have any orders currently",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }else
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => UserOrderDetail(userId: orderProvider.cartList[index].userId, item: index,)));
                              }
                              ,child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.grey.shade200,
                                        width: 1,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 20,
                                      child: orderProvider.cartList[index].userImage != ""
                                          ?Image.network(orderProvider.cartList[index].userImage!)
                                          : Icon(Icons.person_outline),
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        orderProvider.cartList[index].userName??"",
                                        style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                          'Order: ${orderProvider.cartList[index].orderQuantity} ${orderProvider.cartList[index].orderName}'),
                                      Text('Address: ${orderProvider.cartList[index].userAddress}'),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        child: Text(
                                          'Rs. ${int.parse(orderProvider.cartList[index].orderPrice!) * orderProvider.cartList[index].orderQuantity!}',
                                          style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(
                                        'Status: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      Container(
                                        height:30,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: getStatusColor(orderProvider.cartList[index].status),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child:
                                        //Text("pending")
                                        DropdownButtonHideUnderline(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: getStatusColor(orderProvider.cartList[index].status), // Set the background color here
                                              borderRadius: BorderRadius.circular(4), // Optional: Add border radius
                                            ),
                                            child: DropdownButton<String>(
                                              value: orderProvider.cartList[index].status,
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  orderProvider.cartList[index].status = newValue!;
                                                });
                                                orderProvider.updateOrderStatus(orderProvider.cartList[index].orderId!, orderProvider.cartList[index].status!);
                                              },
                                              items: <String>[
                                                'pending',
                                                'preparing',
                                                'delivering',
                                                'delivered'
                                              ].map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: TextStyle(fontSize: 14),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),

                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                          ],
                        );
                    },
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
