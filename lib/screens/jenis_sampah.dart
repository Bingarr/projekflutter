import 'package:flutter/material.dart';
import 'package:trashgrab/jenissampah/kaleng.dart';
import 'package:trashgrab/jenissampah/besi.dart';
import 'package:trashgrab/jenissampah/kardus.dart';
import 'package:trashgrab/jenissampah/kertas.dart';
import 'package:trashgrab/jenissampah/plastik.dart';
import 'package:trashgrab/jenissampah/sampah_organik.dart';

class JenisSampah extends StatelessWidget {
  const JenisSampah({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jenis Sampah'),
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  width: 180,
                  height: 225,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 236, 232, 232),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const KalengScreen()));
                        },
                        child: Image.asset('assets/icons/kaleng.png',
                            width: 155, height: 140),
                      ),
                      const Text(
                        'Kaleng',
                        style: TextStyle(fontSize: 18),
                      ),
                      const Text(
                        'Rp 5000/kg',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  width: 180,
                  height: 225,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 236, 232, 232),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const PlastikScreen()));
                        },
                        child: Image.asset('assets/icons/sampah-plastik.webp',
                            width: 155, height: 140),
                      ),
                      const Text(
                        'Plastik',
                        style: TextStyle(fontSize: 18),
                      ),
                      const Text(
                        'Rp 4500/kg',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  width: 180,
                  height: 225,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 236, 232, 232),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const KardusScreen()));
                        },
                        child: Image.asset('assets/icons/kardus.png',
                            width: 155, height: 140),
                      ),
                      const Text(
                        'Kardus',
                        style: TextStyle(fontSize: 18),
                      ),
                      const Text(
                        'Rp 4000/kg',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  width: 180,
                  height: 225,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 236, 232, 232),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const KertasScreen()));
                        },
                        child: Image.asset('assets/icons/kertas.jpg',
                            width: 155, height: 140),
                      ),
                      const Text(
                        'Kertas',
                        style: TextStyle(fontSize: 18),
                      ),
                      const Text(
                        'Rp 3000/kg',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  width: 180,
                  height: 225,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 236, 232, 232),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const BesiScreen(),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/icons/besi.jpg',
                          width: 155,
                          height: 140,
                        ),
                      ),
                      const Text(
                        'Besi',
                        style: TextStyle(fontSize: 18),
                      ),
                      const Text(
                        'Rp 6000/kg',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  width: 180,
                  height: 225,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 236, 232, 232),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const OrganikScreen(),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/icons/sampah-organik.jpeg',
                          width: 155,
                          height: 140,
                        ),
                      ),
                      const Text(
                        'Sampah Organik',
                        style: TextStyle(fontSize: 18),
                      ),
                      const Text(
                        'Rp 0/kg',
                        style: TextStyle(fontSize: 15),
                      ),
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
