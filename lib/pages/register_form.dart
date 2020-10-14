import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meet_app/exports.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  AuthService _authService;
  DbService _dbService;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String fullName = "";
  String email = "";
  String password = "";

  FocusNode nameNode;
  FocusNode emailNode;
  FocusNode passwordNode;
  FocusNode password1Node;

  Size get s => MediaQuery.of(context).size;

  @override
  void initState() {
    _authService = AuthService();
    nameNode = FocusNode();
    emailNode = FocusNode();
    passwordNode = FocusNode();
    password1Node = FocusNode();
    _dbService = DbService();
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
            Opacity(
              opacity: 0.0,
              child: Container(
                width: s.width,
                height: s.height,
                child: Image.asset(
                  "assets/images/signin.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 140,
              top: -226,
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
            Positioned(
              left: -60,
              top: -172,
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
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  width: s.width,
                  height: s.height,
                  padding: EdgeInsets.symmetric(horizontal: 36),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      SizedBox(
                        height: 140,
                      ),
                      Container(
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
                              color: Colors.black26,
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
                      Text(
                        "Join us, it's free.",
                        style: GoogleFonts.montserrat(
                          color: Color(0xFF161F3D).withOpacity(0.7),
                          fontSize: 26,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      SignInput(
                        focusNode: nameNode,
                        validator: (val) {
                          if (val.contains(" ") && val.length > 5) {
                            return null;
                          } else {
                            return "Enter your full name, please.";
                          }
                        },
                        hintText: "Full Name",
                        onChanged: (val) {
                          fullName = val;
                        },
                        keyboardType: TextInputType.name,
                        obsecureText: false,
                        onFieldSubmitted: (v) {
                          FocusScope.of(context).nextFocus();
                        },
                      ),
                      SizedBox(height: 10),
                      SignInput(
                        focusNode: emailNode,
                        validator: (val) {
                          if (val.contains("@") &&
                              val.contains(".") &&
                              val.length > 7)
                            return null;
                          else
                            return "Email is not valid.";
                        },
                        onChanged: (val) {
                          email = val;
                        },
                        keyboardType: TextInputType.emailAddress,
                        hintText: "Email",
                        obsecureText: false,
                        onFieldSubmitted: (v) {
                          FocusScope.of(context).nextFocus();
                        },
                      ),
                      SizedBox(height: 10),
                      SignInput(
                        focusNode: passwordNode,
                        validator: (val) {
                          if (val.length > 5) {
                            return null;
                          } else {
                            return "Password must be 6 and more characters.";
                          }
                        },
                        onChanged: (val) {
                          password = val;
                        },
                        keyboardType: TextInputType.text,
                        hintText: "Password",
                        obsecureText: true,
                        onFieldSubmitted: (v) {
                          FocusScope.of(context).nextFocus();
                        },
                      ),
                      SizedBox(height: 10),
                      SignInput(
                        focusNode: password1Node,
                        validator: (val) {
                          print(val);
                          print(password);
                          if (val == password)
                            return null;
                          else
                            return "Passwords are not match.";
                        },
                        onChanged: null,
                        keyboardType: TextInputType.text,
                        hintText: "Re-Type Password",
                        obsecureText: true,
                        onFieldSubmitted: (v) {
                          FocusScope.of(context).unfocus();
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
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            FocusScope.of(context).unfocus();

                            print("Full Name: " +
                                fullName +
                                "\n" +
                                "Email: " +
                                email +
                                "\n" +
                                "Password: " +
                                password +
                                "\n");

                            try {
                              await _authService
                                  .signUpWithEmailAndPass(email, password)
                                  .whenComplete(() async {
                                Provider.of<UserSignMethod>(context)
                                    .changeMethod('email');
                                var uid = _authService.auth.currentUser.uid;

                                UserModel userModel = UserModel(
                                  uid: uid,
                                  email: email,
                                  name: fullName,
                                  state: 1,
                                  status: 'user',
                                  userName: email.split("@")[0],
                                  profilePhoto: "",
                                );

                                await _dbService
                                    .addDataToUserTable(userModel, uid)
                                    .then((value) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => Home(uid: uid),
                                    ),
                                  );
                                });
                              });
                            } on FirebaseAuthException catch (e) {
                              print("Register Error: $e");
                            }
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have adn account?",
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                              );
                            },
                            child: Text(
                              "Sign In",
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
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
            ),
          ],
        ),
      ),
    );
  }
}
