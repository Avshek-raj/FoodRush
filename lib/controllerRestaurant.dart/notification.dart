import 'package:flutter/material.dart';

class NotifRestaurant extends StatefulWidget {
  const NotifRestaurant({super.key});

  @override
  State<NotifRestaurant> createState() => _NotifRestaurantState();
}

class _NotifRestaurantState extends State<NotifRestaurant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    BackButton(
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    // Spacer(),
                    Text(
                      "Notifications",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                    Spacer(),
                    Icon(Icons.notifications_active_outlined,color: Colors.red,)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(
                      "Order Request",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Spacer(),
                    Text(
                      "See All",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //for notification
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
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
                          )),
                      child: CircleAvatar(
                        // radius: 25,
                        child: Image.asset(
                          "assets/images/p22.png",
                          // height: 40,
                          // width: 40,
                          fit: BoxFit.cover,
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.74,
                            child: Text(
                              "Samjhana Shrestha has ordered Jhol MO:MO and Mixed Pizza",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                              softWrap: true,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //elevated button
              SizedBox(
                height: 50,
                width: 250,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 100,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Colors.red,
                          ),
                          onPressed: () {},
                          child: Text("Details")),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      height: 40,
                      width: 100,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.red, backgroundColor: Colors.white,
                          ),
                          onPressed: () {},
                          child: Text("Delete")),
                    ),
                  ],
                ),
              ),

              Divider(),
              //arko notification dekhauna
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
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
                          )),
                      child: CircleAvatar(
                        // radius: 25,
                        child: Image.asset(
                          "assets/images/p11.png",
                          // height: 40,
                          // width: 40,
                          fit: BoxFit.cover,
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.74,
                            child: Text(
                              "Daniel Gurung has ordered Chicken Pizza and Pepperoni Pizza",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                              softWrap: true,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //elevated button
              SizedBox(
                height: 50,
                width: 250,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 100,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Colors.red,
                          ),
                          onPressed: () {},
                          child: Text("Details")),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      height: 40,
                      width: 100,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.red, backgroundColor: Colors.white,
                          ),
                          onPressed: () {},
                          child: Text("Delete")),
                    ),
                  ],
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
