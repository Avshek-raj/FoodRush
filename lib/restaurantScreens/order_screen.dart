import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/restaurantScreens/restaurantHome.dart';
import 'package:foodrush/restaurantScreens/userDetails_screen.dart';
import 'package:provider/provider.dart';

import '../providers/order_provider.dart';

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
                  Spacer(),
                  Icon(Icons.notifications_active_outlined, color: Colors.red),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.90,
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
                                Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetail(userId: orderProvider.cartList[index].userId, item: index,)));
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
                                          : Icon(Icons.supervised_user_circle),
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
                                      Text('Address: ${data[index].address}'),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '\RS:${int.parse(orderProvider.cartList[index].orderPrice!) * orderProvider.cartList[index].orderQuantity!}',
                                        style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'Status: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: data[index].statusColor,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          data[index].statusColor == Colors.green
                                              ? 'Delivered'
                                              : 'Pending',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
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
