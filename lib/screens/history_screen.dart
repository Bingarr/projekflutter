import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashgrab/models/item_model.dart';
import 'package:trashgrab/providers/transaction_provider.dart';
import 'package:trashgrab/screens/detail_activity.dart';
import 'package:trashgrab/utils/extensions/tap_extension.dart';
import 'package:trashgrab/utils/function.dart';
import 'package:trashgrab/utils/space_extension.dart';
import 'package:trashgrab/widgets/history_entry.dart';
import 'package:trashgrab/utils/extensions/string_extensions.dart';
import 'package:trashgrab/utils/extensions/date_format.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        leading: const SizedBox(),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: provider.streamAll,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.hasError) {
            return const Text('error');
          }
          final data = snapshot.data?.docs
              .where((item) =>
                  item['user_id'] == provider.firebaseAuth.currentUser?.uid)
              .toList();
          encapFunction(
            () => provider.updateData(data),
          );

          return ListView.separated(
            physics: const ClampingScrollPhysics(),
            itemCount: provider.data.length,
            padding: const EdgeInsets.all(5),
            separatorBuilder: (_, i) => 8.verticalSpace,
            itemBuilder: (_, i) {
              return HistoryEntry(
                driverName: provider.data[i]['petugas_nama'],
                vehicleNumber: provider.data[i]['petugas_plat'],
                location: provider.data[i]['alamat'],
                dateTime:
                    (provider.data[i]['tanggal'] as String?).toFormatDateTime(),
                status: provider.data[i]['status'],
                total: (provider.data[i]['total'] as int? ?? 0).formatNumber(),
              ).extCupertino(onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetailActivity(
                      petugasNama:
                          provider.data[i]['petugas_nama'] as String? ?? '-',
                      petugasPlat:
                          provider.data[i]['petugas_plat'] as String? ?? '-',
                      alamat: provider.data[i]['alamat'] as String? ?? '-',
                      status: provider.data[i]['status'] as String? ?? '-',
                      tanggal: provider.data[i]['tanggal'] as String? ?? '',
                      total: provider.data[i]['total'] as int? ?? 0,
                      barang: List<ItemModel>.from(
                        (provider.data[i]['barang']).map(
                          (item) => ItemModel.fromJson(
                            item as Map<String, dynamic>? ??
                                <String, dynamic>{},
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              });
            },
          );
        },
      ),
    );
  }
}
