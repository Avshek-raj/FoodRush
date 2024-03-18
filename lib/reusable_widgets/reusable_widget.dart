

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Screens/MenuPage.dart';
import '../Screens/cart_screen.dart';
import '../utils/color_utils.dart';

import '../models/location_model.dart';
int? cartItemNumber;

String? deliveryAddress;
String? deliveryLandmark;


bool isLoading = false;

DeliveryInfoModel deliveryIngoModel = DeliveryInfoModel();

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width:320,
    height: 320,
  );
}

TextFormField reusableTextFormField(String text, IconData icon, String fieldInputType,
    TextEditingController controller) {
  bool isPasswordType = fieldInputType == 'password'? true : false;
  return TextFormField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.black,
    style: TextStyle(color: Colors.black.withOpacity(0.9)),
      validator: (value){
        if (isPasswordType){
          if (value!.isEmpty){
            return "Please enter your password";
          } else if(value.length <=7) {
            return "The password should be at least 8 characters";
          }
        }else {
          if (value!.isEmpty) {
            return 'Please enter your ' + text.toLowerCase();
          }
        }
        if (isPasswordType){
          if (value!.isEmpty){
            return "Please enter your password";
          } else if(value.length <=7) {
            return "The password should be at least 8 characters";
          }
        }
        return null;
      },
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 16.0),
      prefixIcon: Icon(
        icon,
        color: Colors.red,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.black54),
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.red,)),
    ),
    keyboardType: fieldInputType == 'password'
        ? TextInputType.visiblePassword
        : fieldInputType == 'email' ? TextInputType.emailAddress
        : fieldInputType == 'phone' ? TextInputType.phone
        : TextInputType.text
  );
}

Container loginButton(BuildContext context, String title, Function onTap) {
  return Container(
    width: 250,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
    ),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.white12;
            }
            return Colors.red;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}

Container customLoginButton(BuildContext context, String title, String logo, Color borderColor, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(90),
      border: Border.all(
        color: Colors.grey,
        width: 1.0,
      )
    ),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child:Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            logo, // Replace with your Google logo asset
            height: 30.0,
          ),
          SizedBox(width: 20,),
          //Icon(Icons.supervised_user_circle),
          Text(
            title,
            style: TextStyle(
                color: Colors.black54,  fontSize: 16),
          ),
        ],
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.red;
            }
            return Colors.white;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}

Row dividerOrLine() {
  return Row(
    children: [
      Expanded(
        child: Divider(
          color:Colors.black,
          height: 20
        )
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text('OR'),
      ),
      Expanded(
          child: Divider(
              color:Colors.black,
              height: 20
          )
      ),
    ],
  );
}

TextField reusableTextField(String text, IconData icon, String fieldInputType,
    TextEditingController controller, Function(String)? onSubmittedCallback) {
  bool isPasswordType = fieldInputType == 'password'? true : false;
  return TextField(
      controller: controller,
      obscureText: isPasswordType,
      enableSuggestions: !isPasswordType,
      autocorrect: !isPasswordType,
      cursorColor: Colors.black,
      style: TextStyle(color: Colors.grey.shade500, fontSize: 15),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 14.0),
        prefixIcon: Icon(
          icon,
          color: Colors.red,
        ),
        labelText: text,
        labelStyle: TextStyle(color: Colors.black54),
        filled: false,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        //fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Colors.red,)),
      ),
      keyboardType: fieldInputType == 'password'
          ? TextInputType.visiblePassword
          : fieldInputType == 'email' ? TextInputType.emailAddress
          : fieldInputType == 'phone' ? TextInputType.phone
          : TextInputType.text,
      onSubmitted: (value) {
        if (onSubmittedCallback != null) {
          onSubmittedCallback(value);
        }
      },
  );
}

GestureDetector menuItem(context, String itemName, String icon){
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Menu()));
    },
    child: Container(
      height: 76,
      width: 76,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.asset(
            icon,
            height: 40,
            width: 40,
          ),
          Text(itemName),
        ],
      ),
    ),
  ) ;
}

Container setItemCount(int count) {
  return Container(
    height: 30,
    width: 107,
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(40),
    ),
    child: Row(
      children: [
        IconButton(
          onPressed: () {

              if (count > 0) {
                count--;
              }
          },
          icon: Icon(Icons.remove), iconSize: 15,
        ),
        Text(
          count.toString(), // Counter value
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: () {
              count++;
          },
          icon: Icon(Icons.add), iconSize: 15,
        ),
      ],
    ),
  );
}

class CartBadge extends StatelessWidget {
  final int itemCount;

  const CartBadge({
    Key? key,
    required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Cart()),
        );
      },
      alignment: Alignment.center,
      padding: EdgeInsets.all(16),
      icon: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.centerLeft,
        children: [
          Icon(Icons.shopping_cart),
          if (itemCount > 0)
            Positioned(
              top: -5,
              right: -5,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: Text(
                  itemCount.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}


