import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodrush/providers/product_provider.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../reusable_widgets/reusable_widget.dart';
import 'orderDescription_screen.dart';

class FoodItem {
  final String name;
  final String description;
  final String price;
  final String imageUrl;
  final String id;
  final String restaurantName;
  final String restaurantId;

  FoodItem({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.id,
    required this.restaurantName,
    required this.restaurantId,
  });
}

class Search extends StatefulWidget {
  String? searchValue;
   Search({Key? key, this.searchValue}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _searchController.text = widget.searchValue ?? ''; // Set initial value to searchValue
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of(context);
    ProductProvider productProvider = Provider.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
        children: [
      Row(
      children: [
      BackButton(
      color: Colors.black,
      ), //back jane button
        Spacer(),
        Text(
          "Search",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        Spacer(),
        CartBadge(
          itemCount: cartProvider.cartList.length,)
        ],
      ),
    Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 14.0),
                labelText: 'Search',
                hintText: 'Search for food items...',
                prefixIcon: Icon(Icons.search, color: Colors.red),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Colors.red,)),
              ),
              onChanged: (value) {
                setState(() {}); // Trigger rebuild with updated search query
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('FoodProducts')
                  .where('productCode', isGreaterThanOrEqualTo: _searchController.text.toLowerCase())
                  .orderBy('productCode')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final List<FoodItem> searchResults = snapshot.data!.docs
                    .map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  return FoodItem(
                    name: data['productName'],
                    description: data['productDescription'],
                    price: data['productPrice'],
                    imageUrl: data['productImage'],
                    id: data['productId'],
                    restaurantName: 'restaurantName',
                    restaurantId: 'restaurantId',
                  );
                })
                    .where((foodItem) => foodItem.name.toLowerCase().contains(_searchController.text.toLowerCase()))
                    .toList();

                return ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    final FoodItem foodItem = searchResults[index];
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    OrderDescription(
                                      productId:
                                      searchResults[
                                      index]
                                          .id,
                                      productName:
                                      searchResults[
                                      index]
                                          .name,
                                      productImage:
                                      searchResults[
                                      index]
                                          .imageUrl,
                                      productPrice:
                                      searchResults[
                                      index]
                                          .price,
                                      productDesc:
                                      searchResults[
                                      index]
                                          .description,
                                      restaurantName: searchResults[
                                      index]
                                          .restaurantName,
                                      restaurantId: searchResults[
                                      index]
                                          .restaurantId, role: 'user',
                                    )));
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey), // Add border decoration
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white54// Optional: Add border radius
                          ),
                          child: ListTile(
                            leading: Image.network(
                              foodItem.imageUrl,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              foodItem.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            trailing: Text(
                              '\Rs. ${foodItem.price}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      )
    );
  }
}
