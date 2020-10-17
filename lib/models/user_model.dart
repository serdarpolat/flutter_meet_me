class UserModel {
  String uid;
  String name;
  String email;
  String userName;
  String status;
  int state;
  String profilePhoto;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.userName,
    this.status,
    this.state,
    this.profilePhoto,
  });

  Map toMap(UserModel user) {
    Map data = Map<String, dynamic>();

    data['uid'] = user.uid;
    data['name'] = user.name;
    data['email'] = user.email;
    data['userName'] = user.userName;
    data['status'] = user.status;
    data['state'] = user.state;
    data['profile_photo'] = user.profilePhoto;

    return data;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    this.uid = map['uid'];
    this.name = map['name'];
    this.email = map['email'];
    this.userName = map['userName'];
    this.status = map['status'];
    this.state = map['state'];
    this.profilePhoto = map['profile_photo'];
  }
}
