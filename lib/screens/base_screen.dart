import 'package:provider/provider.dart';
import 'package:trashgrab/constants/color.dart';
import 'package:trashgrab/providers/base_provider.dart';
import 'package:flutter/material.dart';
import 'package:trashgrab/screens/chart_screen.dart';
import 'package:trashgrab/screens/featuerd_screen.dart';
import 'package:trashgrab/screens/history_screen.dart';
import 'package:trashgrab/screens/jenis_sampah_admin_screen.dart';
import 'package:trashgrab/screens/profile_screen.dart';
import 'package:trashgrab/screens/staff_screen.dart';
import 'package:trashgrab/screens/transaction_screen.dart';
import 'package:trashgrab/utils/hive/role_hive_service.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BaseProvider>();

    return Scaffold(
      body: IndexedStack(
        index: provider.index,
        children: [
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
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kPrimaryColor,
        backgroundColor: Colors.white,
        elevation: 0,
        items: [
          if (RoleHiveServices.getRole()?.role == 0) ...const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Beranda",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: "Riwayat",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: "Keranjang",
            ),
          ] else ...const [
            BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle_sharp),
              label: "Petugas",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.interests),
              label: "Tipe",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long),
              label: "Transaksi",
            ),
          ],
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
        currentIndex: provider.index,
        onTap: provider.changeIndex,
      ),
    );
  }
}
