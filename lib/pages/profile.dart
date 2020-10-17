import 'package:flutter/material.dart';
import 'package:meet_me/index.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  AuthService _authService;

  @override
  void initState() {
    _authService = AuthService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text("Sign Out"),
          onPressed: () {
            _authService.googleSignOut().whenComplete(
                  () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => MyApp(),
                    ),
                  ),
                );
          },
        ),
      ),
    );
  }
}
