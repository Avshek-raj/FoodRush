import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/providers/product_provider.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../reusable_widgets/reusable_widget.dart';
import 'orderDescription_screen.dart';

class TopLiked {
  String? image, price, name;
  TopLiked({this.image, this.name, this.price});
}

List<TopLiked> data = [
  TopLiked(
      image: "assets/images/cheeseburger.png",
      price: "Rs. 400",
      name: "Cheese Burger"),
  TopLiked(
      image: "assets/images/jhol-momo.png",
      price: "Rs. 140",
      name: "Jhol Mo:Mo"),
  TopLiked(
      image: "assets/images/garlicnaan.png",
      price: "Rs. 320",
      name: "Garlic Naan"),
  TopLiked(
      image: "assets/images/spicychicken.png",
      price: "Rs. 500",
      name: "Spicy Chicken"),
  TopLiked(
    image: "assets/images/cd.png",
    price: "Rs. 350",
    name: "Korean Corn Dog",
  )
];
bool isLoading = false;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ProductProvider productProvider;
  late CartProvider cartProvider;
  TextEditingController searchTextController = TextEditingController();

  void handleOtherButtonPress() {
    // Add your logic here
  }

  @override
  void initState() {
    ProductProvider productProvider = Provider.of(context, listen: false);
    CartProvider cartProvider = Provider.of(context, listen: false);
    cartProvider.fetchCartData((){});
    productProvider.fetchFoodProductData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);
    cartProvider = Provider.of(context);
    // ProductProvider productProvider = Provider.of(context);
    // productProvider.fetchFoodProductData();
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
                            child: Icon(
                              Icons.person_outline,
                              size: 30,
                              color: Colors.white,
                            ),
                            backgroundColor: Colors
                                .red, // Optional: you can set the background color of the avatar
                            radius: 35,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Deliver to",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              "Street,City",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            Text(
                              "Nearest landmark",
                              style: TextStyle(
                                  color: Colors.black45, fontSize: 12),
                            ),
                          ],
                        ),
                        Spacer(), // Add some spacing between buttons
                        CartBadge(
                          itemCount: cartProvider.cartList.length,)
                      ],
                    ),
                    SizedBox(height: 15),
                    reusableTextField("Search Food, Drink, etc",
                        Icons.search_outlined, "search", searchTextController),
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
                                menuItem("Pizza", "assets/images/pizza.png"),
                                SizedBox(
                                  width: 15,
                                ),
                                menuItem("Burger", "assets/images/burger.png"),
                                SizedBox(
                                  width: 15,
                                ),
                                menuItem(
                                    "Chicken", "assets/images/chickenfry.png"),
                                SizedBox(
                                  width: 15,
                                ),
                                menuItem("Hotdog", "assets/images/hotdog.png"),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                menuItem("Yomari", "assets/images/yomari.png"),
                                SizedBox(
                                  width: 15,
                                ),
                                menuItem("Sushi", "assets/images/sushi.png"),
                                SizedBox(
                                  width: 15,
                                ),
                                menuItem(
                                    "Noodles", "assets/images/noodles.png"),
                                SizedBox(
                                  width: 15,
                                ),
                                menuItem("All", "assets/images/more.png"),
                              ],
                            ),
                          ],
                        )),

                    //Top liked container
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
                                  "Top Liked",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    "View all",
                                    style: TextStyle(
                                        // color: const Color.fromARGB(255, 55, 151, 59),
                                        color: Colors.red,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
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
                                                  topRight:
                                                      Radius.circular(15)),
                                              child: Image.network(
                                                productProvider
                                                    .foodProductList[index]
                                                    .productImage!,
                                                fit: BoxFit.fill,
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
                                                          fontSize: 16)),
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
                                  "Near you",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    "View all",
                                    style: TextStyle(
                                        // color: const Color.fromARGB(255, 55, 151, 59),
                                        color: Colors.red,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
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
                                  itemCount: data.length,
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0, 10, 10, 10), //2 ta box ko distance
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
                                                topRight: Radius.circular(15)),
                                            child: Image.asset(
                                              data[index].image!,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, left: 10),
                                            child: Row(
                                              children: [
                                                Text(data[index].name!,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16)),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Row(
                                              children: [
                                                Text(
                                                  data[index].price!,
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


