import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class RestaurantPage extends StatelessWidget {
  final DataSnapshot snapshot;
  RestaurantPage(this.snapshot);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.orange),
        title: Text('FoodRun', style: TextStyle(color: Colors.orange),),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Expanded(child: Image.asset('images/food.png')),
                        Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(top: 210.0, right: 2.0),
                          child: Card(
                            color: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 2.0),
                                  child: Text(snapshot.value['Title'], style: TextStyle(color: Colors.white, fontSize: 20.0 , fontWeight: FontWeight.bold),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Text(
                                    snapshot.value['DESCRIPTION'],
                                    style: TextStyle(
                                      color: Colors.yellow.shade100,
                                      fontWeight: FontWeight.bold
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
                ],
              ),
              FlatButton(
                onPressed: null,
                child: Card(
                    margin: EdgeInsets.only(top: 20.0),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25.0, 12.0, 25.0, 12.0),
                      child: Text('Request', style: TextStyle(color: Colors.white, fontSize: 20.0),),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
