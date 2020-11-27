import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.orange, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.orange, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

class VisitedRestaurant extends StatefulWidget {
  @override
  _VisitedRestaurantState createState() => _VisitedRestaurantState();
}

class _VisitedRestaurantState extends State<VisitedRestaurant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 150.0, horizontal: 30.0),
        child: Column(
          children: [
            TextField(
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Restaurant Name'
              ),
            ),
            SizedBox(height: 20.0,),
            TextField(
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Restaurant Location'
              ),
            ),
            SizedBox(height: 20.0,),
            FlatButton(
              onPressed: null,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Text('Post',
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
