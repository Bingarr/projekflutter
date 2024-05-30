import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashgrab/providers/type_provider.dart';
import 'package:trashgrab/utils/extensions/string_extensions.dart';
import 'package:trashgrab/utils/space_extension.dart';
import 'package:trashgrab/widgets/type_item_admin.dart';

class JenisSampahAdminScreen extends StatelessWidget {
  const JenisSampahAdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TypeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('List Jenis Sampah'),
        leading: const SizedBox(),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: provider.streamType,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
      
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text("Loading"),
            );
          }
      
          return ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: snapshot.data?.docs.length ?? 0,
            physics: const ClampingScrollPhysics(),
            separatorBuilder: (_, i) => 5.verticalSpace,
            itemBuilder: (context, i) {
              final data = snapshot.data!.docs[i];
      
              return TypeItemAdmin(
                name: data['name'] ?? '-',
                image: data['image'] ?? '',
                harga: (data['harga'] as int? ?? 0).formatNumber(),
                onTap: () {
                  provider.tapActionType(
                    context: context,
                    isEdit: true,
                    name: data['name'] ?? '-',
                    image: data['image'] ?? '',
                    id: data['id'] ?? '',
                    harga: (data['harga'] as int? ?? 0).toString(),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.small(
        heroTag: 'type',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          provider.tapActionType(
            context: context,
            isEdit: false,
          );
        },
      ),
    );
  }
}
