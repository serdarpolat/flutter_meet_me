import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meet_app/exports.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  AuthService _authService;
  DbService _dbService;
  Size get s => MediaQuery.of(context).size;
  bool isLoaded = false;

  void afterDelay() async {
    await Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isLoaded = true;
      });
    });
  }

  @override
  void initState() {
    _authService = AuthService();
    _dbService = DbService();

    afterDelay();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: s.width,
        height: s.height,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 3000),
              curve: Interval(0.0, 0.24, curve: Curves.easeOutBack),
              right: isLoaded ? -160 : -456,
              top: isLoaded ? -230 : -456,
              child: Container(
                width: 456,
                height: 456,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFF679A3),
                      Color(0xFFE9446A),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 3000),
              curve: Interval(0, 0.2, curve: Curves.easeOutBack),
              left: isLoaded ? -60 : -286,
              top: isLoaded ? -172 : -286,
              child: Container(
                width: 286,
                height: 286,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFF6DC79),
                      Color(0xFFFF9E7B),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 3000),
              curve: Interval(0.0, 0.4, curve: Curves.linearToEaseOut),
              left: 0,
              top: isLoaded ? 0 : s.height,
              child: Container(
                width: s.width,
                height: s.height,
                padding: EdgeInsets.symmetric(horizontal: 36),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    SizedBox(height: 140),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 3000),
                      curve: Interval(0.1, 0.24, curve: Curves.easeOutBack),
                      width: 100,
                      height: 100,
                      padding: EdgeInsets.all(18),
                      child: SvgPicture.asset(
                        "assets/images/heart_icon.svg",
                        semanticsLabel: 'Logo',
                        width: s.width * 0.5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color:
                                isLoaded ? Colors.black26 : Colors.transparent,
                            offset: Offset(0, 16),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      "Welcome!",
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF161F3D).withOpacity(0.7),
                        fontSize: 26,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    SignButton(
                      title: Text(
                        "Login",
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      color: Color(0xFFE9446A),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 24),
                    SignButton(
                      title: Text(
                        "Register",
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      color: Color(0xFFE9446A),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Register(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 24),
                    SignButton(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/google.svg",
                            semanticsLabel: 'Google',
                            width: 24,
                          ),
                          SizedBox(width: 16),
                          Text(
                            "Sign In with Google",
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      color: Color(0xFFEBEBEB),
                      onPressed: () async {
                        await _authService
                            .signInWithGoogle()
                            .then((value) async {
                          Provider.of<UserSignMethod>(context)
                              .changeMethod('google');
                          UserModel user = UserModel(
                            uid: value.uid,
                            email: value.email,
                            name: value.displayName,
                            profilePhoto: value.photoURL,
                            userName: value.email.split("@")[0],
                          );
                          await _dbService
                              .addDataToUserTable(user, value.uid)
                              .then((value1) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Home(
                                      uid: value.uid,
                                    )));
                          });
                        });
                      },
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Created by ",
                          style: GoogleFonts.montserrat(
                            fontSize: 10,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          "Serdar Polat",
                          style: GoogleFonts.montserrat(
                            fontSize: 10,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
