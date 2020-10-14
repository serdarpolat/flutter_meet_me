import 'package:firebase_database/firebase_database.dart';
import 'package:meet_app/models/user_model.dart';

class DbService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.reference();
  final String _userTable = "users";
  final String _categorieTable = "categories";

  DatabaseReference get dbRef => _dbRef.child(_userTable);

  Future<UserModel> addDataToUserTable(UserModel user, String uid) async {
    Map<String, dynamic> data = user.toMap(user);

    await _dbRef.child(_userTable).child(uid).set(data);

    return user;
  }

  Future removeDataFromUserTable(String uid) async {
    await _dbRef.child(_userTable).child(uid).remove();
  }
}
