import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  FirebaseAuth get auth => _auth;

  User _getUser() {
    User user = _auth.currentUser;
    return user;
  }

  User get getUser => _getUser();

  Future<User> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = userCredential.user;
      if (user != null) {
        print("User signed successfully");
        return user;
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      print("Sign in error (email): $e");
      return null;
    }
  }

  Future<User> signUpWithEmailAndPass(String email, String pass) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );

      User user = userCredential.user;

      if (user != null) {
        print("User Registered Successfully.");
        return user;
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      print("Register Error: $e");
      return null;
    }
  }

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount signInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication signInAuthentication =
        await signInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: signInAuthentication.accessToken,
      idToken: signInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);

    final User user = authResult.user;

    if (user != null) {
      return _auth.currentUser;
    } else {
      print("No user!");
      return null;
    }
  }

  Future<void> googleSignOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
