// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:firebase1/util/helper.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class UploadImage extends StatefulWidget {
//   UploadImage({super.key});

//   @override
//   State<UploadImage> createState() => _UploadImageState();
// }

// class _UploadImageState extends State<UploadImage> {
//   bool loader=false;
//   File? file;
//   XFile? image;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(children: [
//           ui(),
//           loader ? Helper.backdropFilter(context) : SizedBox()
//         ],)
//       ),
//     );
//   }
//   ui(){
//     return Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Row(
//                 children: [
//                   Icon(Icons.arrow_back_ios),
//                   Spacer(),
//                   Text(
//                     "Skip",
//                     style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
//                   )
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 100,
//             ),
//             //FOR DOTTED BORDER
//             GestureDetector(
//               //yo chai thichda gallery ma jana ko lagi or inkwell use garda pani hunxa (inkwell for text)
//               onTap: () {
//                 pickImageFromGallery();
//               },
//               child: DottedBorder(
//                 borderType: BorderType.RRect,
//                 radius: Radius.circular(12),
//                 padding: EdgeInsets.all(6),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.all(Radius.circular(10)),
//                   child: Container(
//                     child: file == null
//                         ? Column(
//                             children: [
//                               SizedBox(
//                                 height: 80,
//                               ),
//                               Icon(
//                                 Icons.file_upload_outlined,
//                                 size: 50,
//                               ),
//                               SizedBox(
//                                 height: 20,
//                               ),
//                               Text(
//                                 "Upload Profile Picture",
//                                 style: TextStyle(fontSize: 15),
//                               )
//                             ],
//                           )
//                         : Image.file(
//                             file!,
//                             fit: BoxFit.cover,
//                           ),
//                     height: 250,
//                     width: 320,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//             //for continue wala button
//             SizedBox(
//               height: 30,
//             ),
//             SizedBox(
//               // width: MediaQuery.of(context).size.width*0.9,
//               width: 200,
//               height: 50,
//               child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.red.shade900,
//                     onPrimary: Colors.white,
//                   ),
//                   onPressed: () {
//                     uploadImageToFirebase();
//                   },
//                   child: Text(
//                     "Continue",
//                     style: TextStyle(fontSize: 18),
//                   )),
//             )
//           ],
//         );
//   }

//   pickImageFromGallery() async {
//     //gallery bata image pick garna ko lagi banako function
//     final ImagePicker picker = ImagePicker();
// // Pick an image.
//     image = await picker.pickImage(source: ImageSource.gallery);
//     print(image);
//     if (image == null)
//       return; //yedi image null xa vane tye bata rokera bahira jane
//     file = File(image!.path);
//     setState(() {
//       file;
//       image; //file and image dubai lai aru thau ma notify garnu xa tyesaile
//     });
//   }

//   //
//   uploadImageToFirebase() async {
//     setState(() {
//       loader=true;
//     });
//     final StorageReference =
//         FirebaseStorage.instance.ref(); //storagereference ko object leko
//     var uploadValue = StorageReference.child(image!
//         .name); //aba gallery ma save vako image ko j naam xa tye naam liyeko ho
//     await uploadValue
//         .putFile(file!); //putfile le chai firebase ko "storage" ma upload hanxa

//     //yo chai firebase ko photo url ko form ma liyera upload garna ko lagi
//     final downloadUrl =
//         await StorageReference.child(image!.name).getDownloadURL();
//     print(downloadUrl);

// //yo chai image hamro firestore ma pani dekhauna ko lagi
//     var data = {"image": downloadUrl};
//     await FirebaseFirestore.instance.collection("imagetest").add(data).then((value){
// setState(() {
//   loader=false;
//   file=null;
//   image=null;
// });

//     });
//   }
// }
