import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:food_run/services/post_service.dart';
import 'package:food_run/views/home_page.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
FirebaseDatabase database = FirebaseDatabase.instance;
// ignore: non_constant_identifier_names
Map Blogs;

@override
// ignore: must_be_immutable
class RestaurantRow extends StatelessWidget {
  final DataSnapshot snapshot;
  DatabaseReference _databaseReference;

  final uid = (_firebaseAuth.currentUser).uid;
  final dbRef = FirebaseDatabase.instance.reference();

  RestaurantRow(this.snapshot);

  bool _liked = false;

  @override
  Widget build(BuildContext context) {
//    var size = MediaQuery.of(context).size;
//    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.2;
//    final double itemWidth = size.width;
    return new Container(
      child: new InkWell(
        child: new Card(
          elevation: 2.5,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
//            new Image.network(snapshot.value['IMAGE']),
              new Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
                child: new Text(
                  snapshot.value['Title'],
                  style:
                  new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.deepOrange),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
                child: new Text(
                  snapshot.value['DESCRIPTION'],
                  style: new TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 16.0, color: Colors.orange),
                ),
              ),
              IconButton(
                onPressed: (){
                  //perform deletion here...
                  Query qry = reference.child("Blogs").orderByChild("uid").equalTo("uid");
                },
                icon: Icon(Icons.delete),
                color: Colors.orange,
              ),
              new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new Text(snapshot.value['username'],
                      style: new TextStyle(color: Colors.orange)),
                ],
              ),
            ],
          ),
        ),
        onTap: (){
          Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text("Clicked on "+snapshot.value['ResName']),
          ));
        },
      ),
    );
  }
}