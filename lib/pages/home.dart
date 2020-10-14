import 'package:flutter/material.dart';
import 'package:meet_app/exports.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final String uid;

  const Home({
    Key key,
    this.uid,
  }) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService _authService;
  DbService _dbService;

  Size get s => MediaQuery.of(context).size;

  @override
  void initState() {
    _authService = AuthService();
    _dbService = DbService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: s.width,
        height: s.height,
        child: Center(
          child: Consumer<UserSignMethod>(
            builder: (BuildContext context, state, Widget child) {
              return RaisedButton(
                onPressed: () async {
                  await _dbService.dbRef.once().then((value) async {
                    print(value.value.length);
                    String uid = widget.uid;
                    await _dbService
                        .removeDataFromUserTable(uid)
                        .then((value) async {
                      _authService.auth.currentUser.delete();
                      await _authService.googleSignOut().then((value) async {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => Splash()));
                      });
                    });
                  });
                },
                child: Text("Sign Out"),
              );
            },
          ),
        ),
      ),
    );
  }
}

// RaisedButton(
//               onPressed: () async {
//                 String uid = widget.uid;
//                 await _dbService
//                     .removeDataFromUserTable(uid)
//                     .then((value) async {
//                   _authService.auth.currentUser.delete();
//                   await _authService.googleSignOut().then((value) async {
//                     Navigator.of(context).pushReplacement(
//                         MaterialPageRoute(builder: (context) => Splash()));
//                   });
//                 });
//               },
//               child: Text("Sign Out"),
//             ),
