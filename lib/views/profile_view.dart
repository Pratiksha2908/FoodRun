import 'package:flutter/material.dart';
import 'package:food_run/widgets/provider_widget.dart';
import 'package:intl/intl.dart';
import 'package:food_run/models/User.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  User user = User("");
  bool _isAdmin = false;
  TextEditingController _userCountryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: Provider.of(context).auth.getCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return displayUserInformation(context, snapshot);
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget displayUserInformation(context, snapshot) {
    final authData = snapshot.data;

    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Card(
                  margin: EdgeInsets.all(10.0),
                  child: Center(
                    child: Icon(
                        Icons.person,
                        size: 80.0,
                        color: Color(0xFFffa726),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${authData.displayName ?? 'Anonymous'}",
                    style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text("${authData.email ?? 'Anonymous'}",
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Joined on ${DateFormat('MM/dd/yyyy').format(authData.metadata.creationTime)}",
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500, fontWeight: FontWeight.bold),
                  ),
                  // FutureBuilder(
                  //     future: _getProfileData(),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.connectionState == ConnectionState.done) {
                  //         _userCountryController.text = user.homeCountry;
                  //         _isAdmin = user.admin ?? false;
                  //       }
                  //       return Container(
                  //         child: Column(
                  //           children: <Widget>[
                  //             Text("Location : ${_userCountryController.text}",
                  //               style: TextStyle(fontSize: 12, color: Colors.grey.shade500, fontWeight: FontWeight.bold),
                  //             ),
                  //             adminFeature(),
                  //           ],
                  //         ),
                  //       );
                  //     }
                  // ),
                ],
              ),
              // SizedBox(width: 5.0,),
              // Expanded(
              //   child: FlatButton(
              //     child: Icon(
              //       Icons.edit, color: Color(0xFFffa726),
              //     ),
              //     onPressed: () {
              //       _userEditBottomSheet(context);
              //     },
              //   ),
              // )
            ],
          ),
        ),
        SizedBox(height: 15.0,),
        Container(
          child: Text("Your total rewards : 100 Rupees.",
            style: TextStyle(fontSize: 15.0, color:
            Colors.grey.shade700, fontWeight: FontWeight.bold),
          ),
        ),
        showSignOut(context, authData.isAnonymous),
      ],
    );
  }

  _getProfileData() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    await Provider.of(context)
        .db
        .collection('userData')
        .document(uid)
        .get().then((result) {
          user.homeCountry = result.data['homeCountry'];
          user.admin = result.data['admin'];
    });
  }

  Widget showSignOut(context, bool isAnonymous) {
    if (isAnonymous == true) {
      return RaisedButton(
        child: Text("Sign In To Save Your Data"),
        onPressed: () {
          Navigator.of(context).pushNamed('/convertUser');
        },
      );
    }  else {
      return SizedBox();
    }
    // else {
    //   return RaisedButton(
    //     child: Text("Sign Out"),
    //     onPressed: () {
    //       try {
    //         Provider.of(context).auth.signOut();
    //       } catch (e) {
    //         print(e);
    //       }
    //     },
    //   );
    // }
  }

  Widget adminFeature() {
    if(_isAdmin == true) {
      return Text("You are an admin");
    } else {
      return Container();
    }
  }

  void _userEditBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * .60,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 15.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Update Profile"),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.cancel),
                      color: Colors.orange.shade900,
                      iconSize: 25,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: TextField(
                          controller: _userCountryController,
                          decoration: InputDecoration(
                            helperText: "Location",
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Save'),
                      color: Colors.green,
                      textColor: Colors.white,
                      onPressed: () async {
                        user.homeCountry = _userCountryController.text;
                        setState(() {
                          _userCountryController.text = user.homeCountry;
                        });
                        final uid =
                            await Provider.of(context).auth.getCurrentUID();
                        await Provider.of(context)
                            .db
                            .collection('userData')
                            .document(uid)
                            .setData(user.toJson());
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
