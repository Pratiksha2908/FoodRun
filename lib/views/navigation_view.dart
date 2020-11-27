import 'package:flutter/material.dart';
import 'visited_restaurant.dart';
import 'activity_view.dart';
import 'profile_view.dart';
import 'package:food_run/widgets/provider_widget.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    ProfileView(),
    ActivityView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {try {Provider.of(context).auth.signOut();} catch (e) {print(e);}},
              alignment: Alignment.centerRight,
              icon: Icon(Icons.exit_to_app, color: Color(0xFFffa726),)),
        ],
        title: Text("FoodRun", style: TextStyle(color: Color(0xFFffa726), fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFffa726),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context){ return VisitedRestaurant();}));
        },
        child: Icon(Icons.add, color: Colors.white, size: 40.0,),
        elevation: 2.0,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.person),
                title: new Text("Profile"),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.format_list_bulleted),
                title: new Text("Activity"),
              ),
            ]
        ),
      )
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}