import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/providers/RestaurantProduct_provider.dart';
import 'package:foodrush/providers/product_provider.dart';
import 'package:foodrush/restaurantScreens/navbarRestaurant.dart';
import 'package:foodrush/restaurantScreens/restaurantHome.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../reusable_widgets/reusable_widget.dart';

class EditFood extends StatefulWidget {
  ProductModel productModel;
  EditFood({Key? key, required this.productModel}) : super(key: key);

  @override
  State<EditFood> createState() => _EditFoodState();
}

class _EditFoodState extends State<EditFood> {
  final _formKey = new GlobalKey<FormState>();
  TextEditingController productName = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  TextEditingController productDesc = TextEditingController();
  late RestaurantProductProvider restaurantProductProvider;
  File? productImage;
  String? foodImage;
  XFile? image;

  @override
  Widget build(BuildContext context) {
    productName.text = widget.productModel.productName;
    foodImage=widget.productModel.productImage;
        productPrice.text=widget.productModel.productPrice;
            productDesc.text=widget.productModel.productDesc;



    restaurantProductProvider = Provider.of(context);
    return Scaffold(
      body: SafeArea(
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
                      "Edit Food",
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
                                  ? foodImage !=null?
                                  Image.network(foodImage??"", fit: BoxFit.cover) : Column(
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
                      //for save button
                      loginButton(context, "Save", () {
                        restaurantProductProvider.editProduct(
                          context: context,
                          productId: widget.productModel.productId ,
                          productName: productName.text,
                          productPrice: productPrice.text,
                          productDesc: productDesc.text,
                          productImage: productImage,
                          productImageUrl: widget.productModel.productImage,
                          onSuccess: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Center(
                                      child:
                                          Text("Product edited successfully")),
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
                                        "Your food has been edited successfully and will be shown in the foodlist.",
                                      ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text("Close"),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    NavbarRestaurant())); // Close dialog
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
                      }),
                      SizedBox(
                        height: 20,
                      ),
                      //for delete
                      loginButton(context, "Delete", () {
                        restaurantProductProvider.deleteProductFromFirestore(
                         widget.productModel.productId,
                          onSuccess: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Center(
                                    child: Text("Product deleted successfully"),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        'assets/images/success.png',
                                        fit: BoxFit.fill,
                                        width: 80,
                                        height: 80,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        "Your food has been deleted successfully and will be removed from the food list.",
                                      ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text("Close"),
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> NavbarRestaurant(page: 0,))); // Close dialog
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
                                      child: Text('OK'),
                                    )
                                  ],
                                );
                              },
                            );
                          },
                        );
                      }),
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
