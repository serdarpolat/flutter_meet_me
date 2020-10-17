import 'package:flutter/material.dart';
import 'package:meet_me/models/user_model.dart';
import 'package:meet_me/index.dart';

class Search extends StatefulWidget {
  final String uid;

  const Search({Key key, this.uid}) : super(key: key);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Size get s => MediaQuery.of(context).size;
  DbService _dbService;
  AuthService _authService;
  List<UserModel> userList;
  String searchTitle = "";
  TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();
    _authService = AuthService();
    _dbService = DbService();

    userList = List<UserModel>();

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
            Container(
              width: s.width,
              height: s.height,
              color: Colors.white,
              padding: EdgeInsets.only(
                top: 160,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              child: userList.length > 0
                  ? ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(userList[index].profilePhoto),
                          ),
                          title: Text(
                            userList[index].name,
                          ),
                          subtitle: Text(
                            userList[index].email,
                          ),
                        );
                      },
                    )
                  : Container(),
            ),
            Container(
              width: s.width,
              height: 160,
              color: Colors.pink,
              padding: EdgeInsets.only(
                  left: 20,
                  right: 0,
                  bottom: 20,
                  top: MediaQuery.of(context).padding.top + 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      controller: searchController,
                      onChanged: (val) {
                        setState(() {
                          searchTitle = val;
                        });
                        _dbService
                            .fetchAllUsers(_authService.auth.currentUser)
                            .then((value) {
                          value != null
                              ? value.forEach((element) {
                                  if (element.name.toLowerCase().contains(
                                          searchTitle.toLowerCase()) ||
                                      element.userName.toLowerCase().contains(
                                          searchTitle.toLowerCase())) {
                                    setState(() {
                                      if (userList.isEmpty) {
                                        userList.add(element);
                                      } else {
                                        print(userList[0].name);
                                        print(element.name);
                                        if (userList[0].email != element.email) {
                                          print("Farklı");
                                          userList.add(element);
                                        }
                                      }
                                    });
                                    userList.forEach((user) {
                                      print(user);
                                    });
                                  } else {
                                    print("No User");
                                  }
                                })
                              : print("No user");
                        });
                      },
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.75),
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                      ),
                      cursorColor: Colors.white70,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.close),
                          color: Colors.white,
                          onPressed: () {
                            searchController.clear();
                            setState(() {
                              userList.clear();
                            });
                          },
                        ),
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontWeight: FontWeight.w700,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(Icons.search),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
