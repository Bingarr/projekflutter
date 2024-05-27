import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashgrab/models/item_model.dart';
import 'package:trashgrab/providers/transaction_provider.dart';
import 'package:trashgrab/screens/detail_activity.dart';
import 'package:trashgrab/utils/extensions/tap_extension.dart';
import 'package:trashgrab/utils/space_extension.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionProvider = context.watch<TransactionProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity'),
      ),
      body: ListView.separated(
        physics: const ClampingScrollPhysics(),
        itemCount: transactionProvider.data.length,
        padding: const EdgeInsets.all(20),
        separatorBuilder: (_, i) => 10.verticalSpace,
        itemBuilder: (_, i) {
          String? nama = transactionProvider.data[i]['petugas_nama'] as String?;
          String status =
              transactionProvider.data[i]['status'] as String? ?? '-';

          return Container(
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
            child: ListTile(
              title: Text(
                status == 'Menunggu'
                    ? 'Menunggu admin mengatur penjemputan'
                    : status == 'Dibatalkan'
                        ? 'Penjemputan dibatalkan oleh admin'
                        : "Truk Sampah Menuju Lokasi",
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'ProductSans',
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: nama == null
                  ? null
                  : Text(
                      nama,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'ProductSans',
                      ),
                    ),
              leading: const Icon(Icons.fire_truck_rounded),
              trailing: const Icon(Icons.chevron_right_rounded),
              tileColor: Colors.white,
            ),
          ).extCupertino(onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailActivity(
                  petugasNama:
                      transactionProvider.data[i]['petugas_nama'] as String? ??
                          '-',
                  petugasPlat:
                      transactionProvider.data[i]['petugas_plat'] as String? ??
                          '-',
                  alamat:
                      transactionProvider.data[i]['alamat'] as String? ?? '-',
                  status:
                      transactionProvider.data[i]['status'] as String? ?? '-',
                  tanggal:
                      transactionProvider.data[i]['tanggal'] as String? ?? '',
                  total: transactionProvider.data[i]['total'] as int? ?? 0,
                  barang: List<ItemModel>.from(
                    (transactionProvider.data[i]['barang']).map(
                      (item) => ItemModel.fromJson(
                        item as Map<String, dynamic>? ?? <String, dynamic>{},
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
