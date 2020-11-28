import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


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

final googleSignIn = new GoogleSignIn();
final analytics = new FirebaseAnalytics();
final auth = FirebaseAuth.instance;
final reference = FirebaseDatabase.instance.reference().child('Blogs');

class PostRestaurantPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.white,
            title: new Text('FoodRun', style: TextStyle(color: Colors.orange),),
          ),
          body: new _PostPage()
      ),
    );
  }
}

class _PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => new _PostPageState();
}

class _PostPageState extends State<_PostPage> {
  final TextEditingController _title = new TextEditingController();
  final TextEditingController _desc = new TextEditingController();
  bool _isTitle = false;
  bool _isDesc = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new SingleChildScrollView(
        scrollDirection: Axis.vertical,
        reverse: true,
        child: new Container(
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: _isLoading ? new CircularProgressIndicator(backgroundColor: Colors.orange,) : null,
              ),
              new Padding(padding: const EdgeInsets.only(top: 24.0)),
              new Padding(
                padding: const EdgeInsets.all(20.0),
                child: new TextField(
                  cursorColor: Colors.orange,
                  controller: _title,
                  style: new TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                  onChanged: (String text) {
                    setState(() {
                      _isTitle = text.length > 0;
                    });
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Restaurant Name'
                  ),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(20.0),
                child: new TextField(
                  cursorColor: Colors.orange,
                  controller: _desc,
                  style: new TextStyle(color: Colors.black, fontSize: 18.0),
                  onChanged: (String text) {
                    setState(() {
                      _isDesc = text.length > 0;
                    });
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Restaurant Location'
                  ),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new RaisedButton(
                  padding: const EdgeInsets.only(
                      left: 45.0, right: 45.0, top: 15.0, bottom: 15.0),
                  color: Colors.orange,
                  elevation: 2.0,
                  child: new Text(
                    "Post",
                    style: new TextStyle(color: Colors.white),
                  ),
                  onPressed: _isTitle && _isDesc && !_isLoading
                      ? () => _handleSubmitted(_title.text, _desc.text)
                      : null,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> _handleSubmitted(String title, String desc) async {
    setState(() {
      _isLoading = true;
    });

    // StorageReference ref = FirebaseStorage.instance.ref().child("Blog_Images/" +
    //     new DateTime.now().millisecondsSinceEpoch.toString()); //new//new
    _addBlog(title, desc);
  }

  void _addBlog(String title, String desc) {
//    print(googleSignIn.currentUser.displayName);
//    print(googleSignIn.currentUser.id);
//    print(title);
//    print(imageUrl);
//    print(description);
    reference.push().set({
      'Title': title,
      'DESCRIPTION': desc,
      'uid': (_firebaseAuth.currentUser).uid,
      // 'uid': googleSignIn.currentUser.id,
      'username': _firebaseAuth.currentUser.displayName
    });
//    Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (Builder)))
//    Navigator.of(context).pushAndRemoveUntil(
//        new MaterialPageRoute(
//            builder: (BuildContext context) => new HomePage()),
//        (Route route) => route == null);
//    print("success");
    analytics.logEvent(name: 'post_blog');
    setState(() {
      _isLoading = false;
      _title.clear();
      _desc.clear();
      _isTitle = false;
      _isDesc = false;
    });
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text("Posted Successfully!"),
    ));
  }
}