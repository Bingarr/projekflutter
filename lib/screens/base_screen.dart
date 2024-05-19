import 'package:provider/provider.dart';
import 'package:trashgrab/constants/color.dart';
import 'package:trashgrab/models/role_enum.dart';
import 'package:trashgrab/providers/base_provider.dart';
import 'package:flutter/material.dart';
import 'package:trashgrab/utils/hive/role_hive_service.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BaseProvider>();
    
    return Scaffold(
      body: provider.currentPage,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kPrimaryColor,
        backgroundColor: Colors.white,
        elevation: 0,
        items: [
          if (RoleHiveServices.getRole()?.role ==
              RoleUserCurrent.user) ...const [
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
              icon: Icon(Icons.receipt_long),
              label: "Transaksi",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.interests),
              label: "Tipe",
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
