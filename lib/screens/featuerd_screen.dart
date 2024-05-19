import 'package:flutter/services.dart';
import 'package:trashgrab/constants/color.dart';
import 'package:trashgrab/jenissampah/plastik.dart';
import 'package:trashgrab/jenissampah/kertas.dart';
import 'package:trashgrab/jenissampah/kaleng.dart';
import 'package:trashgrab/jenissampah/kardus.dart';
import 'package:trashgrab/screens/activity.dart';
import 'package:trashgrab/screens/jenis_sampah.dart';
import 'package:flutter/material.dart';

class FeaturedScreen extends StatefulWidget {
  const FeaturedScreen({Key? key}) : super(key: key);

  @override
  _FeaturedScreenState createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreen> {
  @override
  Widget build(BuildContext context) {
    return const AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Column(
          children: [
            AppBar(),
            Body(),
          ],
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                top: 20,
                left: 30,
              ),
              alignment: Alignment.topLeft,
              child: Text(
                "Jadwal Pickup",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      buildDayContainer(context, 'Senin'),
                      buildDayContainer(context, 'Rabu'),
                      buildDayContainer(context, 'Jumat'),
                      buildDayContainer(context, 'Sabtu'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 30, right: 85),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Jenis sampah",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return const JenisSampah();
                      }),
                    );
                  },
                  child: Text(
                    "Lihat lainnya",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: kPrimaryColor),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const KalengScreen(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 7),
                    width: 180,
                    height: 200,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 236, 232, 232),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/icons/kaleng.png',
                          width: 150,
                          height: 120,
                        ),
                        const Text('Kaleng', style: TextStyle(fontSize: 16)),
                        const Text('Rp 5000/kg', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  width: 180,
                  height: 200,
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
                              builder: (context) => const PlastikScreen(),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/icons/sampah-plastik.webp',
                          width: 150,
                          height: 120,
                        ),
                      ),
                      const Text(
                        'Plastik',
                        style: TextStyle(fontSize: 16),
                      ),
                      const Text(
                        'Rp 4500/kg',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  width: 180,
                  height: 200,
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
                              builder: (context) => const KardusScreen(),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/icons/kardus.png',
                          width: 150,
                          height: 120,
                        ),
                      ),
                      const Text(
                        'Kardus',
                        style: TextStyle(fontSize: 16),
                      ),
                      const Text(
                        'Rp 4000/kg',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  width: 180,
                  height: 200,
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
                              builder: (context) => const KertasScreen(),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/icons/kertas.jpg',
                          width: 150,
                          height: 120,
                        ),
                      ),
                      const Text(
                        'Kertas',
                        style: TextStyle(fontSize: 16),
                      ),
                      const Text(
                        'Rp 3000/kg',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Activity(),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(right: 20, left: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 5),
                      color: Colors.green.shade400.withOpacity(.2),
                      spreadRadius: 2,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const ListTile(
                  title: Text(
                    "Truk Sampah Menuju Lokasi",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'ProductSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "Nabila",
                    style: TextStyle(fontSize: 16, fontFamily: 'ProductSans'),
                  ),
                  leading: Icon(Icons.fire_truck_rounded),
                  trailing: Icon(Icons.chevron_right_rounded),
                  tileColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildDayContainer(BuildContext context, String day) {
    return GestureDetector(
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2101),
        );
      },
      child: Container(
        width: 80,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 7),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 236, 232, 232),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const Icon(Icons.date_range_rounded),
            Text(day),
          ],
        ),
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  const AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 100,
        bottom: 20, // add last
        left: 20,
        right: 20,
      ),
      // height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.1, 0.5],
          colors: [
            Color.fromARGB(255, 67, 136, 69),
            Color.fromARGB(255, 21, 111, 24),
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello,\nGood Morning",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              // CircleButton(
              //   icon: Icons.notifications,
              //   onPressed: () {},
              // ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          // const SearchTextField()
        ],
      ),
    );
  }
}
