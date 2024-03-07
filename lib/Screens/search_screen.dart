import 'package:flutter/material.dart';
import 'package:foodrush/providers/search_provider.dart';
import 'package:provider/provider.dart';

import '../reusable_widgets/reusable_widget.dart';

class FoodItem {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  FoodItem({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

List<FoodItem> dummyFoodItems = [
  FoodItem(
    name: "Cheeseburger",
    description: "Juicy beef patty with melted cheese on a bun",
    price: 8.99,
    imageUrl: "https://example.com/cheeseburger.jpg",
  ),
  FoodItem(
    name: "Caesar Salad",
    description: "Fresh romaine lettuce with Caesar dressing and croutons",
    price: 8.99,
    imageUrl: "https://example.com/caesarsalad.jpg",
  ),
  FoodItem(
    name: "Margherita Pizza",
    description: "Classic pizza with tomato sauce, mozzarella, and basil",
    price: 10.99,
    imageUrl: "https://example.com/margheritapizza.jpg",
  ),
  FoodItem(
    name: "Spaghetti Bolognese",
    description: "Spaghetti with rich meat sauce and parmesan cheese",
    price: 12.99,
    imageUrl: "https://example.com/spaghettibolognese.jpg",
  ),
  FoodItem(
    name: "Chocolate Cake",
    description: "Decadent chocolate cake with frosting",
    price: 5.99,
    imageUrl: "https://example.com/chocolatecake.jpg",
  ),
  // Add more food items as needed
];

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  @override
  Widget build(BuildContext context) {
    SearchProvider searchProvider = Provider.of<SearchProvider>(context);
    return Scaffold(
        body: FoodMenu()
    );
  }
}



class FoodMenu extends StatelessWidget {
  TextEditingController searchTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      BackButton(
                        color: Colors.black,
                      ),
                      Spacer(),
                      CartBadge(
                        itemCount: 3, // Replace this with
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),reusableTextField("Search Food, Drink, etc",
            Icons.search_outlined, "search", searchTextController),
        Expanded(
          child: ListView.builder(
            itemCount: dummyFoodItems.length,
            itemBuilder: (context, index) {
              FoodItem foodItem = dummyFoodItems[index];
              return ListTile(
                leading: Image.network(
                  foodItem.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                title: Text(foodItem.name),
                subtitle: Text(foodItem.description),
                trailing: Text('\$${foodItem.price.toStringAsFixed(2)}'),
              );
            },
          ),
        ),
      ],
    );
  }
}
