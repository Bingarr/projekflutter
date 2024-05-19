import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trashgrab/models/role_enum.dart';
import 'package:trashgrab/screens/chart_page.dart';
import 'package:trashgrab/screens/featuerd_screen.dart';
import 'package:trashgrab/screens/history.dart';
import 'package:trashgrab/screens/profile.dart';
import 'package:trashgrab/utils/hive/role_hive_service.dart';

class BaseProvider extends ChangeNotifier {
  int index = 0;

  void changeIndex(int value) {
    index = value;
    notifyListeners();
  }

  Widget get currentPage => _widgetOptions[index];

  static final List<Widget> _widgetOptions = <Widget>[
    if (RoleHiveServices.getRole()?.role == RoleUserCurrent.user) ...const [
      FeaturedScreen(),
      HistoryPage(),
      ChartPage(),
    ] else ...[
      Container(),
      Container(),
    ],
    const ProfileScreen(),
  ];
}
