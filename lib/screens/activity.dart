import 'package:flutter/material.dart';

class Activity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity'),
      ),
      body: GestureDetector(
          child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 20, left: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 5),
                      color: Colors.green.shade400.withOpacity(.2),
                      spreadRadius: 2,
                      blurRadius: 10)
                ]),
            child: ListTile(
              title: Text(
                "Truk Sampah Menuju Lokasi",
                style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'ProductSans',
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Nabila",
                style: const TextStyle(fontSize: 16, fontFamily: 'ProductSans'),
              ),
              leading: Icon(Icons.fire_truck_rounded),
              trailing: Icon(Icons.chevron_right_rounded),
              tileColor: Colors.white,
            ),
          ),
        ],
      )),
    );
  }
}
