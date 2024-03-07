import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/ui_custom/TextFormCus.dart';
import 'package:foodrush/utils/color_utils.dart';
import 'package:image_picker/image_picker.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  File? file;
  XFile? image;
  @override
  Widget build(BuildContext context) {
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
                color: Colors.black,
              ),
              SizedBox(width: 10,),
              // Spacer(),
              Text("Add Food",style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
            ],
                   ),
         ),
         
           //yo edit garne field haru
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Ctextform(
                  labelText: "Food Name",
                  prefixIcon: Icon(
                    Icons.fastfood_outlined,
                    color: Colors.red,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return foodNameValidatorStr;
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {},
                ),
              ),
                 SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Ctextform(
                  labelText: "Food Price",
                  prefixIcon: Icon(
                    Icons.currency_exchange_rounded,
                    color: Colors.red,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return foodpriceValidatorStr;
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {},
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Ctextform(
                  labelText: "Food Description",
                  prefixIcon: Icon(
                    Icons.description_outlined,
                    color: Colors.red,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return foodDescriptionValidatorStr;
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {},
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //upload image of food
            //FOR DOTTED BORDER
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
                    child: file == null ? Column(
                            children: [
                              SizedBox(
                                height: 80,
                              ),
                              Icon(
                                Icons.file_upload_outlined,color: Colors.red,
                                size: 45,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Upload here",
                                style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
                              )
                            ],
//yedi file null xaina vane image.file means device ko file bata image liyera dekhaune ano dotted border vitra fill hune gare select gareko photo dekhaune
                          ): Image.file(file!, fit: BoxFit.cover,), 
                    height: 250,
                    width: 320,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
                height: 50,
              ), 
              SizedBox(
                height: 50,
                        width: 250,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                primary: Colors.red,
                  ),
                  onPressed: (){
                
                }, child: Text("Save")),
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
    file = File(image!.path); //image ko path liyeko
    setState(() {
      file;
      image; //file and image dubai aaye paxi dubai lai aru thau ma notify garnu xa tyesaile
    });
  }
}
