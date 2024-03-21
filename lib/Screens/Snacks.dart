import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<Snacksclass> data = [
  Snacksclass(
      image: "assets/images/sandwich.png",
      price: "Rs. 400",
      name: "Sandwich"),
  Snacksclass(
      image: "assets/images/Tacos.png",
      price: "Rs. 500",
      name: "Tacos"),
  Snacksclass(
      image: "assets/images/Popcorn.png",
      price: "Rs. 550",
      name: "Popcorn"),
  
];

class Snacks extends StatefulWidget {
  const Snacks({super.key});

  @override
  State<Snacks> createState() => SidesState();
}


class SidesState extends State<Snacks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body:  SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: data.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.shade400),
                          borderRadius:
                              BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12)),
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
        ),
    );
  }
}


class Snacksclass {
  String? image, price, name;
  Snacksclass({this.image, this.name, this.price});
}