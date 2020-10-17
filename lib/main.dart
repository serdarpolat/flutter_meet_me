import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meet_me/index.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthService _authService;
  User user;

  @override
  void initState() {
    _authService = AuthService();
    user = _authService.auth.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    user == null ? print("null") : print(user.displayName);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PageState>(create: (context) => PageState()),
      ],
      child: MaterialApp(
        title: 'Meet Me',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/",
        routes: {
          "/search": (context) => Search(),
        },
        home: user == null ? Splash() : Home(),
      ),
    );
  }
}
