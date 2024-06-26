import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/providers/RestaurantProduct_provider.dart';
import 'package:foodrush/restaurantScreens/restaurantHome.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../reusable_widgets/reusable_widget.dart';

List<Map<String, dynamic>> categories = [
  {'name': 'Snacks', 'icon': Icons.fastfood},
  {'name': 'Breakfast', 'icon': Icons.free_breakfast},
  {'name': 'Lunch', 'icon': Icons.restaurant},
  {'name': 'Dinner', 'icon': Icons.dinner_dining},
  {'name': 'Desserts', 'icon': Icons.cake},
  {'name': 'Beverage', 'icon': Icons.local_cafe},
  {'name': 'Comboset', 'icon': Icons.fastfood}, // Example icon, replace as needed
];

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  bool isLoading = false;
  Map<String, dynamic>? selectedCategory;
  final _formKey = new GlobalKey<FormState>();
  TextEditingController productName = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  TextEditingController productDesc = TextEditingController();
  late RestaurantProductProvider restaurantProductProvider;
  File? productImage;
  XFile? image;
  @override
  Widget build(BuildContext context) {
    restaurantProductProvider = Provider.of(context);
    return Scaffold(
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      ):SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    BackButton(
                         onPressed: () {
                        // Navigate back to the previous page
                        Navigator.pop(context);
                      },
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),

                    // Spacer(),
                    Text(
                      "Add Food",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ],
                ),
              ),

              //yo edit garne field haru
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
                child: Form(
                    key: _formKey,
                    child: Column(children: [
                      SizedBox(
                        height: 20,
                      ),
                      reusableTextFormField("Food name",
                          Icons.fastfood_outlined, "text", productName),
                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextFormField("Food Price",
                          Icons.currency_exchange, "price", productPrice),
                      const SizedBox(
                        height: 20,
                      ),
                    DropdownButtonFormField<Map<String, dynamic>>(
                      value: selectedCategory,
                      onChanged: (Map<String, dynamic>? newValue) {
                        setState(() {
                          selectedCategory = newValue;
                        });
                      },
                      items: categories.map<DropdownMenuItem<Map<String, dynamic>>>((category) {
                        return DropdownMenuItem<Map<String, dynamic>>(
                          value: category,
                          child: Row(
                            children: [
                              Icon(category['icon'], color: Colors.red,),
                              SizedBox(width: 8), // Adjust the space between icon and text
                              Text(category['name'], style: TextStyle(fontSize: 15),),
                            ],
                          ),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50), // Adjust the border radius
                        ),
                        labelStyle: TextStyle(
                          color: Colors.black, // Label text color
                          fontSize: 16, // Label text font size
                        ),
                        // Custom label with icon
                        label: Row(
                          children: [
                            Icon(Icons.category_outlined, color: Colors.red,), // Icon for the label
                            SizedBox(width: 8), // Adjust the space between icon and text
                            Text('Category', style: TextStyle(color: Colors.black.withOpacity(0.5)),), // Text for the label
                          ],
                        ),
                      ),// Reduce the height of the dropdown menu
                    ),
                      SizedBox(height: 20),
                      reusableTextFormField("Food Description",
                          Icons.description_outlined, "address", productDesc),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        //yo chai thichda gallery ma jana ko lagi or inkwell use garda pani hunxa (inkwell for text)
                        onTap: () {
                          pickImageFromGallery();
                        },
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: Radius.circular(12),
                          padding: EdgeInsets.all(6),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Container(
                              child: productImage == null
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          height: 80,
                                        ),
                                        Icon(
                                          Icons.file_upload_outlined,
                                          color: Colors.red,
                                          size: 45,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "Upload food image here",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
//yedi file null xaina vane image.file means device ko file bata image liyera dekhaune ano dotted border vitra fill hune gare select gareko photo dekhaune
                                    )
                                  : Image.file(
                                      productImage!,
                                      fit: BoxFit.cover,
                                    ),
                              height: 250,
                              width: 320,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      loginButton(context, "Save", () {
                        setState(() {
                          isLoading = true;
                        });
                        Map<String, dynamic>? data = selectedCategory;

                        String name = data?['name']; // Accessing the name field
                        print(name);
                        restaurantProductProvider.addProduct(
                          context: context,
                          productName: productName.text,
                          productPrice: productPrice.text,
                          productDesc: productDesc.text,
                          productImage: productImage,
                          category: name,
                          onSuccess: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Center(
                                      child: Text("Product added successfully")),
                                  content: Column(
                                    mainAxisSize: MainAxisSize
                                        .min, // To minimize the dialog size
                                    children: [
                                      Image.asset(
                                        'assets/images/success.png',
                                        fit: BoxFit
                                            .fill, // Provide the correct asset path here
                                        width: 80, // Adjust the width as needed
                                        height:
                                            80, // Adjust the height as needed
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        "Your food has been added successfully and will be shown in the foodlist.",
                                      ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text("Close"),
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Close dialog
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          onError: (e) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Error"),
                                    content: Text(e.toString()),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK'))
                                    ],
                                  );
                                });
                          },
                        );
                      })
                    ])),
              ),
            ],
          ),
        ),
      ),
    );
  }

  pickImageFromGallery() async {
    //gallery bata image pick garna ko lagi banako function
    final ImagePicker picker = ImagePicker();
// Pick an image.
    image = await picker.pickImage(source: ImageSource.gallery);
    print(image);
    if (image == null)
      return; //yedi image null xa vane or user le image select gareko xaina vane tye bata rokera bahira jane
    productImage = File(image!.path); //image ko path liyeko
    setState(() {
      productImage;
      image; //file and image dubai aaye paxi dubai lai aru thau ma notify garnu xa tyesaile
    });
  }
}
