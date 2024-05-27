import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashgrab/providers/base_provider.dart';
import 'package:trashgrab/providers/type_provider.dart';
import 'package:trashgrab/utils/extensions/string_extensions.dart';
import 'package:trashgrab/utils/function.dart';
import 'package:trashgrab/widgets/grid_type_item.dart';

class JenisSampahScreen extends StatelessWidget {
  const JenisSampahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final baseProvider = context.watch<BaseProvider>();
    final provider = context.watch<TypeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jenis Sampah'),
      ),
      body: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.89,
        ),
        padding: const EdgeInsets.all(8),
        itemCount: provider.listTye?.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, i) {
          return GridTypeItem(
            name: provider.listTye![i]['name'] ?? '-',
            imageUrl: provider.listTye![i]['image'] ?? '',
            harga: (provider.listTye![i]['harga'] as int? ?? 0).formatNumber(),
            onTap: () async {
              bool navigate = await provider.tapDetailType(
                context: context,
                nama: provider.listTye![i]['name'] ?? '-',
                image: provider.listTye![i]['image'] ?? '',
                idType: provider.listTye![i]['id'] ?? '',
                listId: provider.listTye![i]['list_id'] ?? <dynamic>[],
                harga:
                    (provider.listTye![i]['harga'] as int? ?? 0).formatNumber(),
              );
              if (navigate) {
                pop(context);
                baseProvider.changeIndex(2);
              }
            },
          );
        },
      ),
    );
  }
}
