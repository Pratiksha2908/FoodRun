import 'dart:async';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:food_run/views/restaurant_row.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

final googleSignIn = new GoogleSignIn();
final analytics = new FirebaseAnalytics();
final auth = FirebaseAuth.instance;
final reference = FirebaseDatabase.instance.reference().child('Blogs');
String temp;

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  bool loggedIn = false;
  SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Container(
          child: new Stack(alignment: Alignment.bottomRight, children: <Widget>[
            new FirebaseAnimatedList(
              query: reference,
              sort: (a, b) => b.key.compareTo(a.key),
              padding: new EdgeInsets.all(8.0),
              reverse: false,
              itemBuilder: (_, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return RestaurantRow(snapshot);
              },
            ),
            new Divider(height: 1.0),
            new Builder(
              builder: (BuildContext context) {
                return new Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 12.0),
                  child: new FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/chat");
                    },
                    child: new Icon(Icons.chat),
                  ),
                );
              },
            )
          ]),
        ));
  }

  @override
  void initState() {
    super.initState();
  }
}