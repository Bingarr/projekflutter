import 'package:flutter/material.dart';
import 'package:trashgrab/constants/color.dart';
import 'package:trashgrab/utils/extensions/string_extensions.dart';
import 'package:trashgrab/utils/extensions/tap_extension.dart';
import 'package:trashgrab/utils/space_extension.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.id,
    required this.status,
    this.doReject,
    this.doApprove,
    this.doDone,
    required this.nama,
    required this.harga,
  }) : super(key: key);

  final String id;
  final String status;
  final String nama;
  final int harga;
  final Function()? doReject;
  final Function()? doApprove;
  final Function()? doDone;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(id),
            Text(nama),
            Text(harga.formatNumber2()),
            10.verticalSpace,
            Align(
              alignment: Alignment.centerRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (status == 'Menunggu' &&
                      doReject != null &&
                      doApprove != null) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.person_add_alt_rounded,
                          size: 30,
                          color: kPrimaryColor,
                        ).extCupertino(onTap: doApprove),
                        20.horizontalSpace,
                        const Icon(
                          Icons.remove_circle_rounded,
                          size: 30,
                          color: Colors.red,
                        ).extCupertino(onTap: doReject),
                        10.horizontalSpace,
                      ],
                    ),
                  ],
                  if (status == 'Selesai' || status == 'Dibatalkan') ...[
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        status,
                        style: const TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            status == 'Selesai' ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                  if (status == 'Dalam Perjalanan' && doDone != null) ...[
                    Row(
                      children: [
                        const Icon(
                          Icons.fire_truck_rounded,
                          size: 30,
                          color: Colors.grey,
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.playlist_add_check_rounded,
                          size: 40,
                          color: kPrimaryColor,
                        ).extCupertino(onTap: doDone),
                        10.horizontalSpace,
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
