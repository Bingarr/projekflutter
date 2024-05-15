import 'package:education_app/constants/color.dart';
import 'package:education_app/constants/icons.dart';
import 'package:education_app/constants/size.dart';
import 'package:education_app/main.dart';
import 'package:education_app/screens/featuerd_screen.dart';
import 'package:education_app/screens/history.dart';
import 'package:education_app/screens/profile.dart';
import 'package:education_app/charts/chart_page.dart';
import 'package:education_app/charts/bookmark_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    FeaturedScreen(), 
    HistoryPage(),
    ChartPage(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: kPrimaryColor,
          backgroundColor: Colors.white,
          elevation: 0,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Beranda",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: "Riwayat",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: "Keranjang",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profil",
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }
}
