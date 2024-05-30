import 'package:flutter/material.dart';
import 'package:trashgrab/models/item_model.dart';
import 'package:trashgrab/providers/bookmark_provider.dart';
import 'package:trashgrab/providers/type_provider.dart';
import 'package:trashgrab/screens/bookmark_screen.dart';
import 'package:provider/provider.dart';
import 'package:trashgrab/utils/extensions/date_format.dart';
import 'package:trashgrab/utils/extensions/string_extensions.dart';
import 'package:trashgrab/utils/extensions/tap_extension.dart';
import 'package:trashgrab/utils/function.dart';
import 'package:trashgrab/utils/space_extension.dart';
import 'package:trashgrab/widgets/chart_item.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BookmarkProvider>(context);
    var typeProvider = Provider.of<TypeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text(
          "Keranjang",
          textAlign: TextAlign.center,
        ),
        actions: [
          Row(
            children: [
              Text(provider.count.toString()),
              IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (provider.count == 0) {
                    doSnackbar(context, 'Item is empty');
                    return;
                  }
                  if (provider.dateValue == null) {
                    doSnackbar(context, 'Date is empty');
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookmarksScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.verticalSpace,
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Tanggal Penjemputan',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            10.verticalSpace,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Text(
                  provider.dateValue.toFormatGeneralDate(),
                  style: const TextStyle(
                    color: Colors.black87,
                  ),
                ),
              ).extCupertino(onTap: () {
                provider.pickDateTime(context);
              }),
            ),
            20.verticalSpace,
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Daftar Jenis Sampah',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            10.verticalSpace,
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                separatorBuilder: (_, index) => 5.verticalSpace,
                itemCount: typeProvider.listTye?.length ?? 0,
                itemBuilder: (context, i) {
                  String id = typeProvider.listTye![i]['id'] ?? '';
                  int itemCount = provider.getCountItem(id);
                  final data = ItemModel(
                    nama: typeProvider.listTye![i]['name'] ?? '-',
                    harga: typeProvider.listTye![i]['harga'] as int? ?? 0,
                    image: typeProvider.listTye![i]['image'] ?? '',
                    id: id,
                    totalItem: 1,
                  );

                  return ChartItem(
                    itemCount: itemCount.toString(),
                    name: data.nama,
                    image: data.image,
                    harga: data.harga.formatNumber(),
                    removeTap: itemCount == 0
                        ? null
                        : () {
                            provider.removeItem(data);
                          },
                    addTap: () {
                      provider.addItems(data);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
