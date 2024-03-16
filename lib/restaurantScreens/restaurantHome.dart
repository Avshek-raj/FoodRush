import 'package:flutter/material.dart';

List<OrderStatus> data = [
  OrderStatus(
    avatarImage: "assets/images/p33.png",
    customerName: "Samjhana Shrestha",
    orderNumber: "123456",
    address: "Ram Mandir, Banepa",
    amount: "214000",
    statusColor: Colors.green,
  ),
  OrderStatus(
    avatarImage: "assets/images/p11.png",
    customerName: "Abhishek Raj Singh",
    orderNumber: "101545s",
    address: "25 Kilo, Banepa",
    amount: "400",
    statusColor: Colors.green,
  ),
  OrderStatus(
    avatarImage: "assets/images/p22.png",
    customerName: "Shreeti Shrestha",
    orderNumber: "545454",
    address: "Bhimsenthan, Banepa",
    amount: "3540",
    statusColor: Colors.red,
  ),
  OrderStatus(
    avatarImage: "assets/images/p22.png",
    customerName: "Anita Shrestha",
    orderNumber: "545454",
    address: "Bhimsenthan, Banepa",
    amount: "100",
    statusColor: Colors.green,
  ),
  OrderStatus(
    avatarImage: "assets/images/p22.png",
    customerName: "Shreeti Shrestha",
    orderNumber: "545454",
    address: "Bhimsenthan, Banepa",
    amount: "100",
    statusColor: Colors.red,
  ),
];
List<YourFood> data2 = [
  YourFood(
      image: "assets/images/chhoila.png",
      price: "Rs. 200",
      name: "Buff Chhoila"),
      YourFood(
      image: "assets/images/khajaset.png",
      price: "Rs. 320",
      name: "Newari Khaja-Set"),
  YourFood(
      image: "assets/images/jhol-momo.png", 
      price: "Rs. 140", 
      name: "Jhol Mo:Mo"),
  YourFood(
      image: "assets/images/spicychicken.png",
      price: "Rs. 500",
      name: "Spicy Chicken"),
  YourFood(
    image: "assets/images/cd.png",
    price: "Rs. 350",
    name: "Korean Corn Dog",
  )
];

class HomeRestaurant extends StatefulWidget {
  const HomeRestaurant({Key? key}) : super(key: key);

  @override
  State<HomeRestaurant> createState() => _HomeRestaurantState();
}

class _HomeRestaurantState extends State<HomeRestaurant> {
  TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Container(
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(
      color: Colors.grey.shade200,
      width: 1,
    ),
  ),
  child: CircleAvatar(
    radius: 35,
    backgroundColor: Colors.transparent,
    child: ClipOval(
      child: Image.asset(
        "assets/images/newalahana.png",
        fit: BoxFit.cover,
      ),
    ),
  ),
),

                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello,",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Newa Lahana",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.notifications_on_outlined,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
              // for search box
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width * 0.90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: Colors.grey.shade500),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.search_rounded,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Search Your Food, Drink, etc",
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              // for order status
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:10 ),
                    child: Text(
                    
                      "Order Status",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.30,
                width: MediaQuery.of(context).size.width * 0.90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade500),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
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
                                  child: Image.asset(data[index].avatarImage),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              SizedBox(width: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index].customerName!,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                      'Order Number: ${data[index].orderNumber}'),
                                  Text('Address: ${data[index].address}'),
                                ],
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '\RS:${data[index].amount}',
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
                          Divider(),
                        ],
                      );
                    },
                  ),
                ),
              ),
              //for  YourFood
              SizedBox(height: 10,),
                     Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text(
                            "Your Food",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Spacer(),
                          Text(
                            "View all",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 55, 151, 59),
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 10),
                   child: Row(
                        children: [
                          SizedBox(
                            height: 230,
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(
                                    10), //2 ta box ko distance
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15)),
                                        child: Image.asset(
                                          data2[index].image!,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 10),
                                        child: Row(
                                          children: [
                                            Text(data2[index].name!,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18)),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Row(
                                          children: [
                                            Text(
                                              data2[index].price!,
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                 ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderStatus {
  String avatarImage;
  String? customerName, orderNumber, address, amount;
  Color? statusColor;

  OrderStatus({
    required this.avatarImage,
    this.customerName,
    this.orderNumber,
    this.address,
    this.amount,
    this.statusColor,
  });
}
class YourFood {
  String? image, price, name;
  YourFood({this.image, this.name, this.price});
}
