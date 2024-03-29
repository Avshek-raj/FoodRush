import 'package:flutter/material.dart';
import 'package:foodrush/ui_custom/customElevatedButton.dart';

class reviewPage extends StatefulWidget {
  const reviewPage({super.key});

  @override
  State<reviewPage> createState() => _reviewPageState();
}

class _reviewPageState extends State<reviewPage> {
  double _productRating = 0.0; // Initialize product rating

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Row(
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
                    "Review Food",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ],
              ),
              Container(
                height: 220,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          "Dwarika",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade200),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.asset(
                                "assets/images/Tacos.png", // Modify the path to match the correct location of the image
                                height: 40,
                                width: 40,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Tacos",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Text(
                              "RS.500",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Select Product Rating",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      StarRating(
                        rating: _productRating,
                        onRatingChanged: (rating) {
                          setState(() {
                            _productRating = rating;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 220,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add Written Review",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText:
                              "Write your review here...", // Hint text for the TextFormField
                                  hintStyle: TextStyle(fontSize: 14), // Set the font size of the hint text

                          enabledBorder: InputBorder
                              .none, // Remove the border when not focused
                          focusedBorder: InputBorder
                              .none, // Remove the border when focused
                        ),
                        maxLines: null, // Allow multiple lines for the review
                      ),
                  
                    ],
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
      foregroundColor: Colors.white,
      backgroundColor: Colors.red,
    ),
    onPressed: () {
      // Show message dialog when button is pressed
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text("Thank you for your review!"),
            actions: [
              TextButton(
                onPressed: () {
                  // Close the dialog
                  Navigator.of(context).pop();
                },
                child: Text("OK",style: TextStyle(color: Colors.red),),
              ),
            ],
          );
        },
      );
    },
    child: Text("Submit"),
  ),
),

            ],
          ),
        ),
      ),
    );
  }
}

class StarRating extends StatefulWidget {
  final double rating;
  final ValueChanged<double> onRatingChanged;

  StarRating({this.rating = 0.0, required this.onRatingChanged});

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          return IconButton(
            icon: Icon(
              index < widget.rating ? Icons.star : Icons.star_border,
              color: Colors.amber,
              size: 45,
            ),
            onPressed: () => widget.onRatingChanged(index + 1),
          );
        }),
      ),
    );
  }
}
