import 'package:flutter/widgets.dart';

class PageState with ChangeNotifier {
  int _page = 2;
  String _title = "Messages";

  int get page => _page;
  String get title => _title;

  changePage(int i) {
    _page = i;
    switch (i) {
      case 0:
        _title = "Explorer";
        break;
      case 1:
        _title = "Match";
        break;
      case 2:
        _title = "Messages";
        break;
      case 3:
        _title = "Profile";
        break;
    }
    notifyListeners();
  }
}
