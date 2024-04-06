import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/restaurantScreens/order_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../Screens/deliverto.dart';
import '../providers/order_provider.dart';
import '../providers/user_provider.dart';
import '../reusable_widgets/reusable_widget.dart';
import '../utils/color_utils.dart';
import 'navbarRestaurant.dart';

class UserOrderDetail extends StatefulWidget {

  String? userId; int? item;
   UserOrderDetail({super.key, this.userId, this.item});

  @override
  State<UserOrderDetail> createState() => _UserOrderDetailState();
}

class _UserOrderDetailState extends State<UserOrderDetail> with SingleTickerProviderStateMixin{
  bool isLoading = true;
  late AnimationController animationController;
  late Animation<Offset> _offsetAnimation;
  late GoogleMapController mapController;
  late LatLng _center;
  late LocationData _currentLocation;
  late OrderProvider orderProvider;
  late UserProvider userProvider;
  @override
  void initState()  {
    
    super.initState();
    // RestaurantProvider restaurantProvider = Provider.of(context, listen:false);
    // ProductProvider productProvider = Provider.of(context, listen: false);
    // OrderProvider orderProvider = Provider.of(context, listen:false);
    //  restaurantProvider.fetchRestaurantDetails("",(){});
    //  productProvider.fetchRestaurantProducts();
    //  orderProvider.fetchOrderData((){});
    // MessageProvider messageProvider = Provider.of(context, listen:false);
    // messageProvider.setupFirebaseMessaging(context);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      isLoading = true;
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
        isLoading = false;
      });
    }
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
      // Access inherited widgets or elements here
      // restaurantProvider = Provider.of(context, listen: false);
      // productProvider = Provider.of(context, listen: false);
      orderProvider = Provider.of(context, listen: false);
      userProvider = Provider.of(context, listen: false);
      // restaurantProvider.fetchRestaurantDetails("", () {});
      // productProvider.fetchRestaurantProducts();
      orderProvider.fetchUserOrderData(widget.userId,() {
        userProvider.fetchUserData(widget.userId, (){
          isLoading = false;
        });
      });

      // messageProvider = Provider.of(context, listen: false);
      // messageProvider.setupFirebaseMessaging(context, "Restaurant");


    });


  }
  Set<Marker> _markers = {};
  String statusValue = "";
  LatLng? _markerPosition;
  LatLng? userLatLng ;
  @override
  Widget build(BuildContext context) {
    orderProvider = Provider.of(context);
    userProvider = Provider.of(context);
    _markerPosition = getLatLngFromString(orderProvider.cartList[0].deliveryLatLng);
    userLatLng = getLatLngFromString(userProvider.userInfo.userLatLng);
    if (_markerPosition != null) {
      isLoading = false;
    }
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          BackButton(
                            onPressed: () {
                              orderProvider.fetchOrderData(() {
                                Navigator.pop(context);
                              });
                            },
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),

                          // Spacer(),
                          Text(
                            "Order Detail",
                            style:
                            TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 1,
                        ),
                      ),
                      child: ClipOval(
                          child:
                          //Icon(Icons.person_outline,size: 70,)
                        Image.network(
                          orderProvider.cartList[widget.item??0].userImage??"",
                          fit: BoxFit.cover, // Adjust the height as needed
                        ),
                      ),
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userProvider.userInfo.username??"",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        userProvider.userInfo.email??"",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        userProvider.userInfo.address??"",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        userProvider.userInfo.phone??"",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric( horizontal: 20),
                    child: Text(

                      "Order List",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.30,
                width: MediaQuery.of(context).size.width * 0.90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade500),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: ListView.builder(
                    itemCount: orderProvider.userOrderList.length == 0? 1:  orderProvider.userOrderList.length ,
                    itemBuilder: (context, index) {
                      if (orderProvider.userOrderList.length == 0){
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 100),
                          child: Center(
                            child: Text(
                              "No orders currently",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }else
                        return Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.grey.shade200,
                                      width: 1,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 20,
                                    child: orderProvider.userOrderList[index].orderImage != "" ||orderProvider.userOrderList[index].orderImage != null
                                        ?Image.network(orderProvider.userOrderList[index].orderImage!)
                                        : Icon(Icons.no_food_outlined),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      orderProvider.userOrderList[index].orderName??"",
                                      style:
                                      TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        '${orderProvider.userOrderList[index].orderQuantity} x Rs. ${orderProvider.userOrderList[index].orderPrice}'),
                                    Text('Payment: ${orderProvider.userOrderList[index].payment}'),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '\RS:${int.parse(orderProvider.userOrderList[index].orderPrice!) * orderProvider.userOrderList[index].orderQuantity!}',
                                      style:
                                      TextStyle(fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      'Status: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Container(
                                      height:30,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: getStatusColor(orderProvider.userOrderList[index].status),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child:
                                      //Text("pending")
                                      DropdownButtonHideUnderline(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: getStatusColor(orderProvider.userOrderList[index].status), // Set the background color here
                                            borderRadius: BorderRadius.circular(4), // Optional: Add border radius
                                          ),
                                          child: DropdownButton<String>(
                                            value: orderProvider.userOrderList[index].status,
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                orderProvider.userOrderList[index].status = newValue!;
                                              });
                                              orderProvider.updateOrderStatus(orderProvider.userOrderList[index].orderId!, orderProvider.userOrderList[index].status!);
                                            },
                                            items: <String>[
                                              'pending',
                                              'preparing',
                                              'delivering',
                                              'delivered'
                                            ].map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: TextStyle(fontSize: 14),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),

                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider(),
                          ],
                        );
                    },
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                width: 350,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Row(
                      children: [
                        Text(
                          "Delivery Address",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    //column for name
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name:",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                            Text(
                              "Address:",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                            Text(
                              "Landmark:",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                            Text(
                              "Phone:",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                            ),
                          ],
                        ),
//column for value
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userProvider.deliveryInfoModel.name?? userProvider.userInfo.username??"xxxxx xxxxx",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                              Text(
                                userProvider.deliveryInfoModel.address??userProvider.userInfo.address??"xxxxx, xxxxx",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                              Text(
                                userProvider.deliveryInfoModel.landmark??"xxxxx",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                              Text(
                                userProvider.deliveryInfoModel.phone??userProvider.userInfo.phone??"xxxxxxxxxx",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ]),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Delivery location",
                style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 18),
              ),
              SizedBox(height: 20,),
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
                    target: _markerPosition??userLatLng?? LatLng(0, 0),
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
                                        // setState(() {
                                        //   _markerPosition = latLng; // Update marker position
                                        // });
                                        //address.text = (await getAddressFromLatLng(latLng))!;
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



                    //print(address); // Handle tapped location
                  },
                ),
              ),
              //button halne container
              Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: 250,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: myColor, backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              for (int index = 0; index < orderProvider.userOrderList.length; index++){
                                setState(() {
                                  orderProvider.userOrderList[index].status = "delivering";
                                });
                                orderProvider.updateOrderStatus(orderProvider.userOrderList[index].orderId!, "delivering");

                              }
                            },
                            child: Text(
                              "Delivery in progress",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: 250,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: myColor,
                            ),
                            onPressed: () {
                              for (int index = 0; index < orderProvider.userOrderList.length; index++){
                                setState(() {
                                  orderProvider.userOrderList[index].status = "delivered";
                                });
                                orderProvider.updateOrderStatus(orderProvider.userOrderList[index].orderId!, "delivered");
                                AlertDialog(
                                  title: Text(
                                    "Confirm Logout",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                                  content: Text(
                                    "Are you sure you want to log out?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500, fontSize: 16),
                                  ),
                                  actions: <Widget>[
                                    // Button to logout
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.red,
                                      ),
                                      onPressed: () async {
                                        showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Text(
        "Confirm delivery",
        style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 18),
      ),
      content: Text(
        "Do you really want to mark this order as delivered??",
        style: TextStyle(
          fontWeight: FontWeight.w500, fontSize: 16),
      ),
      actions: <Widget>[
        // Button to logout
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
          ),
          onPressed: () async {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => OrderRequests()));
          },
          child: Text("Yes"),
        ),
        // Button to cancel logout
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text("No"),
        ),
      ],
    );
  },
);

                                      },
                                      child: Text("Yes"),
                                    ),
                                    // Button to cancel logout
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.red,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                      },
                                      child: Text("No"),
                                    ),
                                  ],
                                );
                              }
                              },
                            child: Text(
                              "Delivered",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            )),
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
