import 'package:flutter/material.dart';
import 'package:trashgrab/models/item_model.dart';
import 'package:trashgrab/utils/extensions/date_format.dart';
import 'package:trashgrab/utils/extensions/string_extensions.dart';
import 'package:trashgrab/utils/space_extension.dart';
import 'package:trashgrab/widgets/bookmark_item.dart';

class DetailActivity extends StatelessWidget {
  const DetailActivity({
    Key? key,
    required this.status,
    required this.alamat,
    required this.tanggal,
    required this.petugasNama,
    required this.petugasPlat,
    required this.total,
    required this.barang,
  }) : super(key: key);

  final String status;
  final String alamat;
  final String tanggal;
  final String petugasNama;
  final String petugasPlat;
  final int total;
  final List<ItemModel> barang;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Activity'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
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
            10.verticalSpace,
            Text(
              status == 'Menunggu'
                  ? 'Menunggu admin mengatur penjemputan'
                  : status == 'Dibatalkan'
                      ? 'Penjemputan dibatalkan oleh admin'
                      : '$petugasNama ($petugasPlat)',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            5.verticalSpace,
            Text(
              tanggal.toFormatDateTime(),
            ),
            20.verticalSpace,
            Text(
              'List Barang (${total.formatNumber2()})',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            10.verticalSpace,
            ListView.separated(
              shrinkWrap: true,
              itemCount: barang.length,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, i) => 15.verticalSpace,
              itemBuilder: (_, i) {
                return BookmarkItem(data: barang[i]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
