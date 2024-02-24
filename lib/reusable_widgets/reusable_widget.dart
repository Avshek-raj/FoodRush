
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width:320,
    height: 320,
  );
}

TextFormField reusableTextField(String text, IconData icon, String fieldInputType,
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
        if (value!.isEmpty){
          return 'Please enter a username';
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
        : TextInputType.text
  );
}

Container loginButton(BuildContext context, String title, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
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