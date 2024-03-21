import 'package:flutter/material.dart';
import 'package:foodrush/restaurantScreens/restaurantHome.dart';
import 'package:provider/provider.dart';

import '../providers/order_provider.dart';

class NotifyRestaurant extends StatefulWidget {
   NotifyRestaurant({super.key});

  @override
  State<NotifyRestaurant> createState() => _NotifyRestaurantState();
}

class _NotifyRestaurantState extends State<NotifyRestaurant> {
  late OrderProvider orderProvider;
  @override
  void initState()  {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      orderProvider = Provider.of(context, listen: false);
      orderProvider.fetchOrderList(() {});
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
                      // Navigate to the desired screen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeRestaurant()),
                      );
                    },
                    child: BackButton(
                      color: Colors.black,
                      onPressed: () {
                        // Navigate back to the previous page
                        Navigator.pop(context);
                      },
                    ),
                  ),

                  SizedBox(
                    width: 10,
                  ),
                  // Spacer(),
                  Text(
                    "Order requests",
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  Spacer(),
                  Icon(Icons.notifications_active_outlined,color: Colors.red,)
                ],
              ),
            ),

            SizedBox(
              height: 10,
            ),
            //for notification

            ListView.builder(
              itemCount: orderProvider.cartList.length,
              itemBuilder: (context, index) {
                String? name = orderProvider.orderList[index].user;
                String? order = orderProvider.orderList[index].order;
                String? userImage = orderProvider.orderList[index].userImage;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundImage:  NetworkImage(userImage!),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '$name has ordered $order',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          softWrap: true,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          SizedBox(
                            height: 40,
                            width: 100,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white, backgroundColor: Colors.red,
                              ),
                              onPressed: () {},
                              child: Text("Details"),
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            height: 40,
                            width: 100,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.red, backgroundColor: Colors.white,
                              ),
                              onPressed: () {},
                              child: Text("Delete"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
