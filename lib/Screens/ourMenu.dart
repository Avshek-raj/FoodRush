import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OurMenu extends StatefulWidget {
  const OurMenu({super.key});

  @override
  State<OurMenu> createState() => _OurMenuState();
}

class _OurMenuState extends State<OurMenu> {
  List<bool> isSelected = [
    true,
    false
  ]; 
    PageController pageController = PageController(initialPage: 0); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Row(
                  children: [
                    BackButton(
                      color: Colors.black,
                    ), //back jane button
                    Spacer(),
                    Text(
                      "Our Menu",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    Spacer(),
                   Icon(Icons.shopping_cart)
                  ],
                ),
              ),
              Row(
children: [
  
],
              ),
             
            ],
          ),
        ),
      ),
    );

  }
}
class Meals{
  String? image, price,name;
  Meals({this.image,this.price,this.name});
}