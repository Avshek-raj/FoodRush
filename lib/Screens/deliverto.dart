import 'package:flutter/material.dart';
import 'package:foodrush/Screens/Navigation.dart';
import 'package:foodrush/providers/delivery_provider.dart';

import 'package:foodrush/reusable_widgets/reusable_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '../models/location_model.dart';
import '../providers/user_provider.dart';
import '../reusable_widgets/reusable_widget.dart';
import 'map.dart';


class DeliverTo extends StatefulWidget {
  const DeliverTo({super.key});

  @override
  State<DeliverTo> createState() => DeliverToState();
}

class DeliverToState extends State<DeliverTo>  with SingleTickerProviderStateMixin  {
  late AnimationController animationController;
  late Animation<Offset> _offsetAnimation;
  late GoogleMapController mapController;
  late LatLng _center;
  late LocationData _currentLocation;
  DeliveryProvider deliveryProvider = DeliveryProvider();
  TextEditingController name = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController landmark = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  bool firstLoad = true;

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
    });
  }

  Set<Marker> _markers = {};
  LatLng? _markerPosition;
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    if (firstLoad) {
      name.text = userProvider.deliveryInfoModel.name?? userProvider.userModel.username??"";
      address.text = userProvider.deliveryInfoModel.address??userProvider.userModel.address?? "";
      landmark.text = userProvider.deliveryInfoModel.landmark?? "";
      phone.text = userProvider.deliveryInfoModel.phone??userProvider.userModel.phone?? "";
      firstLoad = false;
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  BackButton(
                    color: Colors.black,
                  ), //back jane button
                  Spacer(),
                  Text(
                    "Deliver to",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                      ),
                      child: Icon(
                        Icons.question_mark,
                        color: Colors.black,
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              //form ko lagi container
              Container(
                width: 360,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    border: Border.all(color: Colors.grey.shade100),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Enter Delivery Info",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                             "Name:",
                            style: TextStyle(fontSize: 17),
                          ),
                          Spacer(),
                          Container(
                            height: 40,
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextField(
                              controller: name,
                            )
                          )

                        ],
                      ),
                        SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "Phone:",
                            style: TextStyle(fontSize: 17),
                          ),
                          Spacer(),
                          Container(
                              height: 40,
                              width: 250,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextField(
                                controller: phone,
                              )
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "Landmark:",
                            style: TextStyle(fontSize: 17),
                          ),
                          Spacer(),
                          Container(
                              height: 40,
                              width: 250,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextField(
                                controller: landmark,
                              )
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "Address:",
                            style: TextStyle(fontSize: 17),
                          ),
                          Spacer(),
                          Container(
                              height: 40,
                              width: 250,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextField(
                                controller: address,
                              )
                          )
                        ],
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Row(
                      //   children: [
                      //     Text(
                      //       "Landmark:",
                      //       style: TextStyle(fontSize: 17),
                      //     ),
                      //     Spacer(),
                      //     Container(
                      //         height: 40,
                      //         width: 250,
                      //         decoration: BoxDecoration(
                      //           color: Colors.white,
                      //           border: Border.all(color: Colors.white),
                      //           borderRadius: BorderRadius.circular(5),
                      //         ),
                      //         child: TextField(
                      //           controller: landmark,
                      //         )
                      //     )
                      //   ],
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Set delivery address",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      SizedBox(height: 20,),

                    ],
                  ),
                ),
              ),
               // SizedBox(
               //          height: 50,
               //        ),
              Container(
                height: 250,
                child:
                GoogleMap(
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
                    //  setState(() async{
                    //   address.text = await getAddressFromLatLng(latLng);
                    // });
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
                                          _markerPosition = latLng; // Update marker position
                                        });
                                        address.text = (await getAddressFromLatLng(latLng))!;
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

              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: SizedBox(
                    height: 50,
                    width: 250,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.red,
                        ),
                        onPressed: (){
                          deliveryProvider.addDeliveryData(context: context, name: name.text, address: address.text, landmark: landmark.text, phone: phone.text, onSuccess: () {
                            userProvider.fetchDeliveryInfo(onSuccess: (){
                              Navigator.of(context, rootNavigator: true).pop();
                            });
                            // Execute any additional code on success
                          },
                            onError: (error) {
                              print('Failed to add product: $error');
                              // Execute any additional code on error
                            },
                          );
                        }, child: Text("Proceed",style: TextStyle(fontWeight: FontWeight.bold),)),
                  ),
                ),
              )
              //proceed button
              
            ],
          ),
        ),
      ),
    );
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



