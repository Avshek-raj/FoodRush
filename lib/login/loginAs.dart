import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodrush/login/restaurantSignIn_screen.dart';
import 'package:foodrush/login/signin_screen.dart';
import 'package:foodrush/restaurantScreens/navbarRestaurant.dart';

import '../Screens/Navigation.dart';
import '../reusable_widgets/reusable_widget.dart';

String? loginAs;

class LoginAs extends StatefulWidget {
  @override
  _LoginAsState createState() => _LoginAsState();
}

class _LoginAsState extends State<LoginAs> {
  late PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirebaseAuth.instance.currentUser != null ?  MainScreen() :Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // PageView and GestureDetector
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPageIndex = index;
                      });
                    },
                    children: [
                      // Page 1
                      Container(
                        color: Colors.transparent,
                        child: Center(
                          child: Column(
                            children: [
                              logoWidget("assets/images/logo_white.png"),
                              Padding(
                                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: loginAsConsumer('Savor Every Moment: Taste the World at Your Doorstep!', 'Discover a wide range of delicious dishes and have them delivered to your doorstep!'),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.fromLTRB(8, 0, 8, MediaQuery.of(context).size.height * 0.1),
                                child: ElevatedButton(
                                  onPressed: () {
                                    loginAs = "user";
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
                                  },
                                  child: SizedBox(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        "Get started",
                                        style: TextStyle(color: Colors.white, fontSize: 25),
                                      ),
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                                      return Colors.transparent;
                                    }),
                                    foregroundColor: MaterialStateProperty.resolveWith((states) {
                                      return states.contains(MaterialState.pressed) ? Colors.red : Colors.white;
                                    }),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        side: BorderSide(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Page 2
                      Container(
                        color: Colors.transparent,
                        child: Center(
                          child: Column(
                            children: [
                              logoWidget("assets/images/logo_white.png"),
                              Padding(
                                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: loginAsConsumer("Expand Your Reach, Serve More Plates.", "Join our platform to expand your culinary reach and showcase your delectable creations to a hungry audience!"),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.fromLTRB(8, 0, 8, MediaQuery.of(context).size.height * 0.1),
                                child: ElevatedButton(
                                  onPressed: () {
                                    loginAs = "restaurant";
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
                                  },
                                  child: SizedBox(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        "Open as a Restaurant owner",
                                        style: TextStyle(color: Colors.white, fontSize: 25),
                                      ),
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                                      return Colors.transparent;
                                    }),
                                    foregroundColor: MaterialStateProperty.resolveWith((states) {
                                      return states.contains(MaterialState.pressed) ? Colors.red : Colors.white;
                                    }),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        side: BorderSide(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //swipeable
                Padding(
                    padding: EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    2, // Number of pages
                        (index) => Padding(
                      padding: EdgeInsets.all(4),
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPageIndex == index ? Colors.white : Colors.grey, // Active page indicator color
                        ),
                      ),
                    ),
                  ),
                ),
                ),
              ],
            ),
          ),
          // Swipe indicator
          Positioned(
            bottom: 280,
            right: _currentPageIndex == 0 ?10 : null,
            left: _currentPageIndex != 0 ?10 : null,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0) {
                  // Swiping right
                  if (_currentPageIndex < 1) {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5), // Semi-transparent black
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _currentPageIndex != 0 ? 'Swipe left to login as Diners' : 'Swipe right to login as a restaurant owner',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container loginAsConsumer(slogan, desc) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5), // Semi-transparent black
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            slogan,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
