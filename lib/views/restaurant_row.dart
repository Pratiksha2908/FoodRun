import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:food_run/views/home_page.dart';
import 'package:food_run/views/restaurant_page.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
FirebaseDatabase database = FirebaseDatabase.instance;
// ignore: non_constant_identifier_names
Map Blogs;

@override
// ignore: must_be_immutable
class RestaurantRow extends StatelessWidget {
  final DataSnapshot snapshot;
  // ignore: non_constant_identifier_names
  DatabaseReference mDatabase = FirebaseDatabase.instance.reference();

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
          child: Row(
            children: [
              Card(
                  margin: EdgeInsets.all(10.0),
                  child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Icon(
                          Icons.restaurant,
                          size: 35.0,
                          color: Colors.orange,
                        ),
                      )
                  )
              ),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
//            new Image.network(snapshot.value['IMAGE']),
                  new Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
                    child: new Text(
                      snapshot.value['Title'],
                      style:
                      new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.deepOrangeAccent),
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
                    child: Text(snapshot.value['username'],
                        style: new TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
        onTap: (){
          Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text("Clicked on "+snapshot.value['Title']),
          ));
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context){
                  return RestaurantPage(snapshot);
                }
              )
          );
        },
      ),
    );
  }
}


// Card(
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Icon(
// Icons.chat,
// color: Colors.orange,
// ),
// ),
// shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
// ),