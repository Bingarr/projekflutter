import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        leading: const SizedBox(),
      ),
      body: ListView(
        children: const [
          HistoryEntry(
            driverName: 'Japran',
            vehicleNumber: 'F 1211 ICK',
            location: 'Universitas Padjajaran',
            dateTime: '29 Nov 07:26',
            serviceType: 'Plastik Botol',
            pricePerKg: 'Rp.3000/kg',
            status: 'Selesai',
          ),
          HistoryEntry(
            driverName: 'Samsul',
            vehicleNumber: 'L 1211 ICK',
            location: 'Universitas Airlangga',
            dateTime: '28 Nov 07:19',
            serviceType: 'Plastik Botol',
            pricePerKg: 'Rp.3000/kg',
            status: 'Dibatalkan',
          ),
        ],
      ),
    );
  }
}

class HistoryEntry extends StatelessWidget {
  final String driverName;
  final String vehicleNumber;
  final String location;
  final String dateTime;
  final String serviceType;
  final String pricePerKg;
  final String status;

  const HistoryEntry({super.key, 
    required this.driverName,
    required this.vehicleNumber,
    required this.location,
    required this.dateTime,
    required this.serviceType,
    required this.pricePerKg,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(driverName[0]),
        ),
        title: Text('$driverName ($vehicleNumber)'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(location),
            Text(dateTime), // Menampilkan tanggal waktu tanpa memilihnya
            Text('$serviceType $pricePerKg'),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {},
          child: Text(status),
          style: ElevatedButton.styleFrom(
            backgroundColor: status == 'Selesai' ? Colors.green : Colors.grey,
          ),
        ),
      ),
    );
  }
}
