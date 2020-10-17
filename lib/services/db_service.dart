import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meet_me/index.dart';

class DbService {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  UserModel userModel = UserModel();

  final GlobalVars gb = GlobalVars();

  Future<bool> isHasUser(User user) async {
    QuerySnapshot snapshot = await firestore
        .collection(gb.usersTable)
        .where("email", isEqualTo: user.email)
        .get();

    final List<DocumentSnapshot> docs = snapshot.docs;

    return docs.length > 0 ? true : false;
  }

  Future<void> addUserToDb(User newUser) async {
    userModel = UserModel(
      uid: newUser.uid,
      email: newUser.email,
      name: newUser.displayName,
      profilePhoto: newUser.photoURL,
      userName: gb.userName(newUser.email),
    );

    firestore
        .collection(gb.usersTable)
        .doc(newUser.uid)
        .set(userModel.toMap(userModel));
  }

  Future<List<UserModel>> _fetchAllUsers(User currentUser) async {
    List<UserModel> userList = List<UserModel>();

    QuerySnapshot querySnapshot =
        await firestore.collection(gb.usersTable).get();

    for (var i = 0; i < querySnapshot.docs.length; i++) {
      userList.add(UserModel.fromMap(querySnapshot.docs[i].data()));
    }

    return userList != null ? userList : null;
  }

  Future<List<UserModel>> fetchAllUsers(User currentUser) =>
      _fetchAllUsers(currentUser);
}
