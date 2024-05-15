import 'package:flutter/material.dart';
import 'package:education_app/jenissampah/Kaleng.dart';
import 'package:education_app/jenissampah/besi.dart';
import 'package:education_app/jenissampah/kardus.dart';
import 'package:education_app/jenissampah/kertas.dart';
import 'package:education_app/jenissampah/plastik.dart';
import 'package:education_app/jenissampah/sampah_organik.dart';

class JenisSampah extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jenis Sampah'),
      ),
      body: GestureDetector(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    blurRadius: 4.0,
                    spreadRadius: .05,
                  ), //BoxShadow
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: EdgeInsets.symmetric(horizontal: 7),
                  width: 180,
                  height: 225,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 236, 232, 232),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => KalengScreen()));
                        },
                        child: Container(
                          child: Image.asset('assets/icons/kaleng.png', width: 155 , height: 140),
                        ),
                      ),
                      Text(
                        'Kaleng',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Rp 5000/kg',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: EdgeInsets.symmetric(horizontal: 7),
                  width: 180,
                  height: 225,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 236, 232, 232),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PlastikScreen()));
                        },
                        child: Container(
                          child: Image.asset('assets/icons/sampah-plastik.webp', width: 155 , height: 140 ),
                        ),
                      ),
                      Text(
                        'Plastik',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Rp 4500/kg',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: EdgeInsets.symmetric(horizontal: 7),
                  width: 180,
                  height: 225,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 236, 232, 232),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => KardusScreen()));
                        },
                        child: Container(
                          child: Image.asset('assets/icons/kardus.png', width: 155 , height: 140 ),
                        ),
                      ),
                      Text(
                        'Kardus',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Rp 4000/kg',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: EdgeInsets.symmetric(horizontal: 7),
                  width: 180,
                  height: 225,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 236, 232, 232),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => KertasScreen()));
                        },
                        child: Container(
                          child: Image.asset('assets/icons/kertas.jpg', width: 155 , height: 140 ),
                        ),
                      ),
                      Text(
                        'Kertas',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Rp 3000/kg',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: EdgeInsets.symmetric(horizontal: 7),
                  width: 180,
                  height: 225,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 236, 232, 232),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => BesiScreen(),
                          ));
                        },
                        child: Container(
                          child: Image.asset('assets/icons/besi.jpg', width: 155 , height: 140 ),
                        ),
                      ),
                      Text(
                        'Besi',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Rp 6000/kg',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: EdgeInsets.symmetric(horizontal: 7),
                  width: 180,
                  height: 225,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 236, 232, 232),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrganikScreen()));
                        },
                        child: Container(
                          child: Image.asset('assets/icons/sampah-organik.jpeg', width: 155 , height: 140 ),
                        ),
                      ),
                      Text(
                        'Sampah Organik',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Rp 0/kg',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
