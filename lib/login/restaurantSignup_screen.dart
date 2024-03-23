import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/login/signin_screen.dart';
import 'package:foodrush/ui_custom/TextFormCus.dart';
import 'package:foodrush/utils/color_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../Screens/home_screen.dart';
import '../Screens/map.dart';
import '../providers/restaurant_provider.dart';
import '../restaurantScreens/navbarRestaurant.dart';
import '../reusable_widgets/reusable_widget.dart';

class RegisterRestaurantScreen extends StatefulWidget {
  const RegisterRestaurantScreen({super.key});

  @override
  State<RegisterRestaurantScreen> createState() => _RegisterRestaurantScreenState();
}

class _RegisterRestaurantScreenState extends State<RegisterRestaurantScreen>  with SingleTickerProviderStateMixin{
  late AnimationController animationController;
  late Animation<Offset> _offsetAnimation;
  late GoogleMapController mapController;
  late LatLng _center;
  late LatLng address ;
  late LocationData _currentLocation;
  late String restaurantLocation;
  late RestaurantProvider restaurantProvider;
  final _formKey = new GlobalKey<FormState>();
  TextEditingController restaurantName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController about = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  File? file;
  XFile? restaurantImage;

  @override
  void initState() {
    super.initState();
    _getLocation();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));

    animationController.forward();
  }

  void _getLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentLocation = await location.getLocation();
    setState(() {
      _center = LatLng(_currentLocation.latitude!, _currentLocation.longitude!);
      address = LatLng(_currentLocation.latitude!, _currentLocation.longitude!);
    });
  }

  Set<Marker> _markers = {};
  LatLng? _markerPosition;
String? restaurantAddress;
  @override
  Widget build(BuildContext context) {
    restaurantProvider = Provider.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset("assets/images/logo_pureRed.png",
                      // height: 150,
                      // width: 150,
                      // ),
                      Text(
                        "Register your restaurant",
                        style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),

                    ],
                  ),
                ),

                //yo edit garne field haru
                SizedBox(
                  height: 5,
                ),
                Form(
                    key: _formKey,
                    child: Column(

                      children:[
                        const SizedBox(
                          height: 30,
                        ),
                        reusableTextFormField("Restaurant name", Icons.restaurant_outlined, "text", restaurantName),
                        const SizedBox(
                          height: 20,
                        ),
                        reusableTextFormField("Email", Icons.mail_outline, "email", email),
                        const SizedBox(
                          height: 20,
                        ),
                        reusableTextFormField("Contact number", Icons.phone_outlined, "phone", phone),
                        const SizedBox(
                          height: 20,
                        ),
                        reusableTextFormField("About Restaurant", Icons.description_outlined, "text", about),
                        const SizedBox(
                          height: 20,
                        ),
                        reusableTextFormField("Password", Icons.lock_outline, "password", password),
                        const SizedBox(
                          height: 20,
                        ),
                        reusableTextFormField("Confirm Password", Icons.lock_outline, "password", confirmPassword),
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
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: Container(
                                child: file == null
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
                                      "Upload your restaurant image here",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                  //yedi file null xaina vane image.file means device ko file bata image liyera dekhaune ano dotted border vitra fill hune gare select gareko photo dekhaune
                                )
                                    : Image.file(
                                  file!,
                                  fit: BoxFit.cover,
                                ),
                                height: 250,
                                width: 320,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Set restaurant location",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          height: 250,
                          child:
                          GoogleMap(
                            buildingsEnabled : true,
                            myLocationEnabled : true,
                            myLocationButtonEnabled :true,
                            onMapCreated: (GoogleMapController controller) {
                              mapController = controller;
                            },
                            initialCameraPosition: CameraPosition(
                              target: _center,
                              zoom: 15.0,
                            ),
                            markers: _markerPosition != null ? Set<Marker>.from([
                              Marker(
                                markerId: MarkerId('chosen-location'),
                                position: _markerPosition!,
                              ),
                            ]) : <Marker>{},
                            onTap: (LatLng latLng) async {
                                restaurantAddress = await getAddressFromLatLng(latLng);
                              showGeneralDialog(
                                context: context,
                                barrierDismissible: true,
                                barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                barrierColor: Colors.black.withOpacity(0.5),
                                transitionDuration: Duration(milliseconds: 500),
                                pageBuilder: (BuildContext buildContext, Animation<double> animation,
                                    Animation<double> secondaryAnimation) {
                                  return SlideTransition(
                                    position: Tween<Offset>(
                                      begin: Offset(0, 1), // Adjust as needed, this is for sliding up from the bottom
                                      end: Offset.zero,
                                    ).animate(animation),
                                    child: Align(
                                      alignment: Alignment.bottomCenter, // Align dialog to the bottom
                                      child: Dialog(
                                        insetPadding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min, // Ensure the dialog takes minimum space
                                          children: [
                                            GestureDetector(
                                              onVerticalDragUpdate: (details) {
                                                if (details.primaryDelta! > 0) {
                                                  Navigator.of(context).pop(); // Close the dialog
                                                }
                                              },
                                              child: Text(
                                                'Tap on your location or swipe down to close',
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context).size.height-121, // Adjust the height as needed
                                              width: MediaQuery.of(context).size.width,
                                              child: GoogleMap(
                                                myLocationEnabled: true,
                                                myLocationButtonEnabled: true,
                                                onMapCreated: (GoogleMapController controller) {
                                                  mapController = controller;
                                                },
                                                initialCameraPosition: CameraPosition(
                                                  target: latLng,
                                                  zoom: 15.0,
                                                ),
                                                onTap: (LatLng latLng) async{
                                                  setState(() {
                                                    _markerPosition = latLng;
                                                    address = latLng;// Update marker position
                                                  });
                                                  restaurantLocation = (await getAddressFromLatLng(latLng))!;
                                                  Navigator.of(context).pop();
                                                  //widget.onLocationSelected(latLng); // Call callback to pass location to parent widget
                                                },
                                                markers: _markerPosition != null
                                                    ? Set<Marker>.from([
                                                  Marker(
                                                    markerId: MarkerId('chosen-location'),
                                                    position: _markerPosition!,
                                                  ),
                                                ])
                                                    : <Marker>{},
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },

                              );



                              print(address); // Handle tapped location
                            },
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                loginButton(context, "Sign Up", () {

                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email.text,
                        password: password.text).then ((value) {
                      value.user?.sendEmailVerification();
                        restaurantProvider.addRestaurantDetails(
                          context: context,
                          restaurantName: restaurantName.text,
                          email: email.text,
                          phone: phone.text,
                          address: restaurantAddress,
                          restaurantLatLng: _markerPosition??_center,
                          password: password.text,
                          about: about.text,
                          restaurantImage: file,
                          onSuccess: (){
                            setState(() {
                              isLoading = false;
                            });
                            showDialog(context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Message"),
                                    content: Text("Verification link is sent to your email. Please verify before login"),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => SignInScreen()));
                                      }, child: Text('OK'))
                                    ],
                                  );
                                });
                          },
                          onError: (e){
                            setState(() {
                              isLoading = false;
                            });
                            showDialog(context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Error"),
                                    content: Text(e.toString()),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.of(context).pop();
                                      }, child: Text('OK'))
                                    ],
                                  );
                                });
                          });
                    }).onError((error, stackTrace) {
                      setState(() {
                        isLoading = false;
                      });showDialog(context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Error"),
                              content: Text(error.toString()),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.of(context).pop();
                                }, child: Text('OK'))
                              ],
                            );
                          });
                      print("Error ${error.toString()}");
                    });
                  }
                  //)
                  // })
                  // FirebaseAuth.instance
                  //     .signInWithEmailAndPassword(
                  //     email: _emailTextController.text,
                  //     password: _passwordTextController.text)
                  //     .then((value) {
                  //   Navigator.push(context,
                  //       MaterialPageRoute(builder: (context) => HomeScreen()));
                  // }).onError((error, stackTrace) {
                  //   print("Error ${error.toString()}");
                  // });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  pickImageFromGallery() async {
    //gallery bata image pick garna ko lagi banako function
    final ImagePicker picker = ImagePicker();
// Pick an image.
    restaurantImage = await picker.pickImage(source: ImageSource.gallery);
    print(restaurantImage);
    if (restaurantImage == null)
      return; //yedi image null xa vane or user le image select gareko xaina vane tye bata rokera bahira jane
    file = File(restaurantImage!.path); //image ko path liyeko
    setState(() {
      file;
      restaurantImage; //file and image dubai aaye paxi dubai lai aru thau ma notify garnu xa tyesaile
    });
  }

  void _onMapTapped(LatLng tappedLatLng) {
    setState(() {
      // Clear previous markers
      _markers.clear();
      // Add a new marker at the tapped location
      _markers.add(
        Marker(
          markerId: MarkerId(tappedLatLng.toString()),
          position: tappedLatLng,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    });
  }
}
