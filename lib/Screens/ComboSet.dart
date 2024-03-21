import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<ComboSetClass> data = [
  ComboSetClass(
      image: "assets/images/mixpizza.png",
      price: "Rs. 400",
      name: "Mixed Pizza"),
  ComboSetClass(
      image: "assets/images/pepperoni.png",
      price: "Rs. 500",
      name: "Pepperoni Pizza"),
  ComboSetClass(
      image: "assets/images/pineapple.png",
      price: "Rs. 550",
      name: "Pineapple Pizza"),
  
];

class ComboSet extends StatefulWidget {
  const ComboSet({super.key});

  @override
  State<ComboSet> createState() => SidesState();
}


class SidesState extends State<ComboSet> {
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


class ComboSetClass {
  String? image, price, name;
  ComboSetClass({this.image, this.name, this.price});
}