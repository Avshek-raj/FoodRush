import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/providers/restaurant_provider.dart';
import 'package:foodrush/restaurantScreens/navbarRestaurant.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../providers/message_provider.dart';
import '../providers/order_provider.dart';
import '../providers/product_provider.dart';
import '../reusable_widgets/reusable_widget.dart';
import 'editFood.dart';

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
bool _isLoading = false;

class HomeRestaurant extends StatefulWidget {
  const HomeRestaurant({super.key});

  @override
  State<HomeRestaurant> createState() => _HomeRestaurantState();
}

class _HomeRestaurantState extends State<HomeRestaurant> {
  TextEditingController searchTextController = TextEditingController();
  late MessageProvider messageProvider;
  late RestaurantProvider restaurantProvider;
  late ProductProvider productProvider;
  late OrderProvider orderProvider;

  @override
  void initState()  {
    isLoading = true;
    super.initState();
    // RestaurantProvider restaurantProvider = Provider.of(context, listen:false);
    // ProductProvider productProvider = Provider.of(context, listen: false);
    // OrderProvider orderProvider = Provider.of(context, listen:false);
    //  restaurantProvider.fetchRestaurantDetails("",(){});
    //  productProvider.fetchRestaurantProducts();
    //  orderProvider.fetchOrderData((){});
    // MessageProvider messageProvider = Provider.of(context, listen:false);
    // messageProvider.setupFirebaseMessaging(context);
    WidgetsBinding.instance?.addPostFrameCallback((_) async{
      
      // Access inherited widgets or elements here
      restaurantProvider = Provider.of(context, listen: false);
      productProvider = Provider.of(context, listen: false);
      orderProvider = Provider.of(context, listen: false);
      await restaurantProvider.fetchRestaurantDetails("", () {});
      await productProvider.fetchRestaurantProducts();
      await orderProvider.fetchOrderData(() {});
      messageProvider = Provider.of(context, listen: false);
      messageProvider.setupFirebaseMessaging(context, "Restaurant");
      isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    restaurantProvider = Provider.of(context);
    productProvider = Provider.of(context);
    orderProvider = Provider.of(context);
    return Scaffold(
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      ): SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,), 
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey.shade200,
                            width: 1,
                          ),
                        ),
                        child: ClipOval(
                          child: restaurantProvider.restaurantModel.restaurantImageLink != null || restaurantProvider.restaurantModel.restaurantImageLink != ""?
                          Image.network(
                            restaurantProvider.restaurantModel.restaurantImageLink.toString(),
                            fit: BoxFit.cover,
                            width: 70, // Adjust the width as needed
                            height: 70, // Adjust the height as needed
                          ) :
                          Image.asset(
                            "assets/images/person.png",
                            fit: BoxFit.cover,
                            width: 70, // Adjust the width as needed
                            height: 70, // Adjust the height as needed
                          ) ,
                        ),
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Greetings,",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          restaurantProvider.restaurantModel.restaurantName??"",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NavbarRestaurant(page: 2,)));
                      },
                      child: Icon(
                        Icons.notifications_on_outlined,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              // for search box
              // Padding(
              //   padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
              //   child: Container(
              //     height: 45,
              //     width: MediaQuery.of(context).size.width * 0.90,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(40),
              //       border: Border.all(color: Colors.grey.shade500),
              //     ),
              //     child: Row(
              //       children: [
              //         SizedBox(
              //           width: 5,
              //         ),
              //         Icon(
              //           Icons.search_rounded,
              //           color: Colors.red,
              //         ),
              //         SizedBox(
              //           width: 10,
              //         ),
              //         Text(
              //           "Search Your Food, Drink, etc",
              //           style: TextStyle(color: Colors.grey.shade500),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 15,
              // ),
              // for order status
              SizedBox(height: 30,), 
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric( horizontal: 20),
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
                                  Text('Address: ${orderProvider.cartList[index].userAddress}'),
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
                                      color: getStatusColor(orderProvider.cartList[index].status),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      orderProvider.cartList[index].status??"",
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
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Row(
                        children: [
                          Text(
                            "Your Food",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Spacer(),
                          // Text(
                          //   "View all",
                          //   style: TextStyle(
                          //       color: const Color.fromARGB(255, 55, 151, 59),
                          //       fontSize: 12,
                          //       fontWeight: FontWeight.bold),
                          // )
                        ],
                      ),
                    ),

                 Padding(
                   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                   child: Row(
                        children: [
                          SizedBox(
                            height: 230,
                            width: MediaQuery.of(context).size.width * 0.89,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: productProvider.foodProductList.length == 0? 1 : productProvider.foodProductList.length,
                              itemBuilder: (context, index) =>
                              productProvider.foodProductList.length == 0 ?
                              Container(
                                width: MediaQuery.of(context).size.width* 0.89,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "You haven't uploaded any foods yet",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                                :  Padding(
                                padding: const EdgeInsets.all(
                                    10), //2 ta box ko distance
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => EditFood( productModel: productProvider.foodProductList[index],)),);
                                  },
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
                                            topRight: Radius.circular(15),
                                          ),
                                          child: SizedBox(
                                            width: MediaQuery.of(context).size.width,
                                            height: 145,// Set your desired height
                                            child: Image.network(
                                              productProvider.foodProductList[index].productImage??"",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 10),
                                          child: Row(
                                            children: [
                                              Text(productProvider.foodProductList[index].productName??"",
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
                                                "Rs. " +productProvider.foodProductList[index].productPrice??"",
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
