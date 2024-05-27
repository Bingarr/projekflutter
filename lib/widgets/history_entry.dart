import 'package:flutter/material.dart';
import 'package:trashgrab/constants/color.dart';
import 'package:trashgrab/utils/space_extension.dart';

class HistoryEntry extends StatelessWidget {
  final String driverName;
  final String vehicleNumber;
  final String location;
  final String dateTime;
  final String total;
  final String status;

  const HistoryEntry({
    super.key,
    required this.driverName,
    required this.vehicleNumber,
    required this.location,
    required this.dateTime,
    required this.total,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text(
                status == 'Menunggu' || status == 'Dibatalkan'
                    ? ''
                    : driverName[0],
              ),
            ),
            title: Text(
              status == 'Menunggu'
                  ? 'Menunggu admin mengatur penjemputan'
                  : status == 'Dibatalkan'
                      ? 'Penjemputan dibatalkan oleh admin'
                      : '$driverName ($vehicleNumber)',
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                3.verticalSpace,
                Text(
                  location,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: kPrimaryColor,
                      ),
                ),
                3.verticalSpace,
                Text(dateTime),
                Text(total),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 10, right: 10),
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                status,
                style: const TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: status == 'Selesai'
                    ? Colors.green
                    : status == 'Dalam Perjalanan'
                        ? Colors.amber
                        : status == 'Dibatalkan'
                            ? Colors.red
                            : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
