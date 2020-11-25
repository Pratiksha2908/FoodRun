import 'package:flutter/material.dart';
import 'package:food_order_app/views/home_view.dart';
import 'package:food_order_app/views/new_trips/location_view.dart';
import 'package:food_order_app/views/past_trips_view.dart';
import 'profile_view.dart';
import 'package:food_order_app/models/Trip.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeView(),
    PastTripsView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    final newTrip = new Trip(null, null, null, null, null, null);
    return Scaffold(
      appBar: AppBar(
        title: Text("Travel Budget App"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewTripLocationView(trip: newTrip,)),
              );
            },
          ),
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.history),
              title: new Text("Past Trips"),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.account_circle),
              title: new Text("Profile"),
            ),
          ]
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}