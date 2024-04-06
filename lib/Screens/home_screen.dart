import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/Screens/search_screen.dart';
import 'package:foodrush/providers/product_provider.dart';
import 'package:foodrush/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../models/location_model.dart';
import '../providers/cart_provider.dart';
import '../providers/message_provider.dart';
import '../reusable_widgets/reusable_widget.dart';
import 'deliverto.dart';
import 'map.dart';
import 'orderDescription_screen.dart';

class NearYou {
  String? image, price, name;
  NearYou({this.image, this.name, this.price});
}

List<NearYou> data = [
  NearYou(
      image: "assets/images/cheeseburger.png",
      price: "Rs. 400",
      name: "Cheese Burger"),
  NearYou(
      image: "assets/images/jhol-momo.png",
      price: "Rs. 140",
      name: "Jhol Mo:Mo"),
  NearYou(
      image: "assets/images/garlicnaan.png",
      price: "Rs. 320",
      name: "Garlic Naan"),
  NearYou(
      image: "assets/images/spicychicken.png",
      price: "Rs. 500",
      name: "Spicy Chicken"),
  NearYou(
    image: "assets/images/cd.png",
    price: "Rs. 350",
    name: "Korean Corn Dog",
  )
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MessageProvider messageProvider;
  late UserProvider userProvider;
  late ProductProvider productProvider;
  late CartProvider cartProvider;
  TextEditingController searchTextController = TextEditingController();

  void handleOtherButtonPress() {
    // Add your logic here
  }

  @override
  void initState() {
    UserProvider userProvider = Provider.of(context, listen: false);
    ProductProvider productProvider = Provider.of(context, listen: false);
    CartProvider cartProvider = Provider.of(context, listen: false);
    userProvider.fetchUserData("",() {});
    cartProvider.fetchCartData(() {});
    productProvider.fetchFoodProductData();
    MessageProvider messageProvider = Provider.of(context, listen:false);
    messageProvider.setupFirebaseMessaging(context, "");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of(context);
    productProvider = Provider.of(context);
    cartProvider = Provider.of(context);
    // ProductProvider productProvider = Provider.of(context);
    // productProvider.fetchFoodProductData();
    if (productProvider.nearestFoods !=null) {
      isLoading = false;
    }
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).size.height * 0.02, 20, 0),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 18, 18, 18),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.red, // Optional: Set the background color of the avatar
                            child: ClipOval(
                              child: userProvider.userModel.userImage != null ?Image.network(
                                userProvider.userModel.userImage ?? "", // Provide the image URL
                                fit: BoxFit.cover, // Adjust the fit as per your requirement
                                width: 70, // Set the width of the clipped image
                                height: 70, // Set the height of the clipped image
                              ) : Icon(Icons.person_outlined),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DeliverTo()));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Deliver to",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              Text(
                                userProvider.deliveryInfoModel.address ??
                                    "street,city",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              Text(
                                userProvider.deliveryInfoModel.landmark ??
                                    "Nearest landmark",
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Spacer(), // Add some spacing between buttons
                        CartBadge(
                          itemCount: cartProvider.cartList.length,
                        )
                      ],
                    ),
                    SizedBox(height: 15),
                    reusableTextField(
                        "Search Food, Drink, etc",
                        Icons.search_outlined,
                        "search",
                        searchTextController, (value) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Search(searchValue: searchTextController.text,)));
                    }),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        height: 200,
                        width: 350,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                
                                menuItem(context, "Snacks",
                                    "assets/images/Vsnacks.png", 1),
                                SizedBox(
                                  width: 15,
                                ),
                                menuItem(context, "Breakfast",
                                    "assets/images/Vbreakfast.png", 2),
                                SizedBox(
                                  width: 15,
                                ),
                                menuItem(context, "Lunch",
                                    "assets/images/Vlunch.png", 3),
                                SizedBox(
                                  width: 15,
                                ),
                                menuItem(context, "Dinner",
                                    "assets/images/Vdinner.png", 4),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                menuItem(context, "Desserts",
                                    "assets/images/Vdessert.png", 5),
                                SizedBox(
                                  width: 15,
                                ),
                                menuItem(context, "Beverage",
                                    "assets/images/Vbeverage.png", 6),
                                SizedBox(
                                  width: 15,
                                ),
                                menuItem(context, "Combo Set",
                                    "assets/images/VCombo.png", 7),
                                SizedBox(
                                  width: 15,
                                ),
                                menuItem(context, "All",
                                    "assets/images/more.png", 0),
                              ],
                            ),
                          ],
                        )),

                    //Near You container
                    Container(
                      height: 210,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        // border: Border.all(color: Colors.grey.shade400)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Row(
                              children: [
                                Text(
                                  "Nearby Eats",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Spacer(),
                                // GestureDetector(
                                //   onTap: () {},
                                //   child: Text(
                                //     "View all",
                                //     style: TextStyle(
                                //         // color: const Color.fromARGB(255, 55, 151, 59),
                                //         color: Colors.red,
                                //         fontSize: 12,
                                //         fontWeight: FontWeight.bold),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 180,
                                width: MediaQuery.of(context).size.width * 0.89,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      productProvider.nearestFoods.length,
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0, 10, 10, 10), //2 ta box ko distance
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OrderDescription(
                                                      productId:
                                                      productProvider
                                                          .nearestFoods[
                                                      index]
                                                          .productId,
                                                      productName:
                                                          productProvider
                                                              .nearestFoods[
                                                                  index]
                                                              .productName,
                                                      productImage:
                                                          productProvider
                                                              .nearestFoods[
                                                                  index]
                                                              .productImage,
                                                      productPrice:
                                                          productProvider
                                                              .nearestFoods[
                                                                  index]
                                                              .productPrice,
                                                      productDesc:
                                                          productProvider
                                                              .nearestFoods[
                                                                  index]
                                                              .productDesc,
                                                      restaurantName: productProvider
                                                          .nearestFoods[
                                                      index]
                                                          .restaurantName,
                                                      restaurantId: productProvider
                                                          .nearestFoods[
                                                      index]
                                                          .restaurantId, role: 'user',
                                                    )));
                                      },
                                      child: Container(
                                        clipBehavior: Clip.antiAlias,
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey.shade400),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15),
                                              ),
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height:
                                                    100, // Set your desired height
                                                child: Image.network(
                                                  productProvider
                                                      .nearestFoods[index]
                                                      .productImage!,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, left: 10),
                                              child: Row(
                                                children: [
                                                  Text(
                                                      productProvider
                                                          .nearestFoods[
                                                              index]
                                                          .productName!,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14),
                                                          overflow: TextOverflow.clip, // or TextOverflow.clip
  maxLines: 1,
                                                           
                                                          ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Rs. " +
                                                        productProvider
                                                            .nearestFoods[
                                                                index]
                                                            .productPrice!,
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
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
                        ],
                      ),
                    ),
                    //All Food container
                    Container(
                      height: 210,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        // border: Border.all(color: Colors.grey.shade400)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Row(
                              children: [
                                Text(
                                  "Full Menu",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Spacer(),
                                // GestureDetector(
                                //   onTap: () {},
                                //   child: Text(
                                //     "View all",
                                //     style: TextStyle(
                                //       // color: const Color.fromARGB(255, 55, 151, 59),
                                //         color: Colors.red,
                                //         fontSize: 12,
                                //         fontWeight: FontWeight.bold),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 180,
                                width: MediaQuery.of(context).size.width * 0.89,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                  productProvider.foodProductList.length,
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0, 10, 10, 10), //2 ta box ko distance
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OrderDescription(
                                                      productId:
                                                      productProvider
                                                          .foodProductList[
                                                      index]
                                                          .productId,
                                                      productName:
                                                      productProvider
                                                          .foodProductList[
                                                      index]
                                                          .productName,
                                                      productImage:
                                                      productProvider
                                                          .foodProductList[
                                                      index]
                                                          .productImage,
                                                      productPrice:
                                                      productProvider
                                                          .foodProductList[
                                                      index]
                                                          .productPrice,
                                                      productDesc:
                                                      productProvider
                                                          .foodProductList[
                                                      index]
                                                          .productDesc,
                                                      restaurantName: productProvider
                                                          .foodProductList[
                                                      index]
                                                          .restaurantName,
                                                      restaurantId: productProvider
                                                          .foodProductList[
                                                      index]
                                                          .restaurantId, role: 'users',
                                                    )));
                                      },
                                      child: Container(
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey.shade400),
                                            borderRadius:
                                            BorderRadius.circular(15)),
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15),
                                                topRight: Radius.circular(15),
                                              ),
                                              child: SizedBox(
                                                width: MediaQuery.of(context).size.width,
                                                height: 100,// Set your desired height
                                                child: Image.network(
                                                  productProvider.foodProductList[index].productImage!,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, left: 10),
                                              child: Row(
                                                children: [
                                                  Text(
                                                      productProvider
                                                          .foodProductList[
                                                      index]
                                                          .productName!,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 14)),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Rs. " +
                                                        productProvider
                                                            .foodProductList[
                                                        index]
                                                            .productPrice!,
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 16),
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
                        ],
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}
