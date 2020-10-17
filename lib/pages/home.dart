import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meet_me/index.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService _authService;
  Size get s => MediaQuery.of(context).size;
  GlobalVars gb;
  PageController pageController;
  ScrollController scrollController;
  double topBarOffset = 0;
  String _currentUserId;

  @override
  void initState() {
    _authService = AuthService();
    scrollController = ScrollController();
    pageController = PageController(
      initialPage: 2,
    );

    gb = GlobalVars();

    _currentUserId = _authService.auth.currentUser.uid;

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
              child: PageView(
                controller: pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Explorer(),
                  Match(),
                  Messages(
                    scrollController: scrollController,
                    topBarOffset: topBarOffset,
                    onNotification: (val) {
                      setState(() {
                        topBarOffset = val.metrics.extentBefore > 60
                            ? 60
                            : val.metrics.extentBefore;
                      });
                      return null;
                    },
                  ),
                  Profile(),
                ],
              ),
            ),
            Consumer<PageState>(
              builder: (context, pageState, widget) {
                return TopBar(
                  title: pageState.title,
                  topBarOffset: topBarOffset,
                  gb: gb,
                  actions: [
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                Search(uid: _currentUserId)));
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        print("More");
                      },
                    ),
                  ],
                );
              },
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Consumer<PageState>(
                builder: (BuildContext context, pageState, Widget child) {
                  return Container(
                    width: s.width,
                    height: 80,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BottomItem(
                          iconPath: "assets/icons/explorer.svg",
                          isActive: pageState.page == 0,
                          onTap: () {
                            pageState.changePage(0);
                            pageController.jumpToPage(pageState.page);
                          },
                        ),
                        BottomItem(
                          iconPath: "assets/icons/match.svg",
                          isActive: pageState.page == 1,
                          onTap: () {
                            pageState.changePage(1);
                            pageController.jumpToPage(pageState.page);
                          },
                        ),
                        BottomItem(
                          iconPath: "assets/icons/messages.svg",
                          isActive: pageState.page == 2,
                          onTap: () {
                            pageState.changePage(2);
                            pageController.jumpToPage(pageState.page);
                          },
                        ),
                        BottomItem(
                          iconPath: "assets/icons/profile.svg",
                          isActive: pageState.page == 3,
                          onTap: () {
                            pageState.changePage(3);
                            pageController.jumpToPage(pageState.page);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomItem extends StatelessWidget {
  final String iconPath;
  final bool isActive;
  final Function onTap;

  const BottomItem({Key key, this.iconPath, this.isActive, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    GlobalVars gb = GlobalVars();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        child: Center(
          child: SvgPicture.asset(
            iconPath,
            color: isActive ? gb.pink : Colors.grey,
            semanticsLabel: 'Bottom Icon',
            width: 30,
          ),
        ),
      ),
    );
  }
}
