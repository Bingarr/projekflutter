import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trashgrab/screens/chart_screen.dart';
import 'package:trashgrab/screens/featuerd_screen.dart';
import 'package:trashgrab/screens/history_screen.dart';
import 'package:trashgrab/screens/jenis_sampah_admin_screen.dart';
import 'package:trashgrab/screens/profile_screen.dart';
import 'package:trashgrab/screens/staff_screen.dart';
import 'package:trashgrab/screens/transaction_screen.dart';
import 'package:trashgrab/utils/hive/role_hive_service.dart';

class BaseProvider extends ChangeNotifier {
  int index = 0;

  /// all user
  void changeIndex(int value) {
    index = value;
    notifyListeners();
  }

  Widget get currentScreen => _widgetOptions[index];

  static final List<Widget> _widgetOptions = <Widget>[
    if (RoleHiveServices.getRole()?.role == 0) ...const [
      FeaturedScreen(),
      HistoryScreen(),
      ChartScreen(),
    ] else ...const [
      StaffScreen(),
      JenisSampahAdminScreen(),
      TransactionScreen(),
    ],
    const ProfileScreen(),
  ];
}
