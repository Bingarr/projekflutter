import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashgrab/providers/staff_provider.dart';
import 'package:trashgrab/utils/function.dart';
import 'package:trashgrab/utils/space_extension.dart';
import 'package:trashgrab/widgets/staff_item.dart';

class StaffScreen extends StatelessWidget {
  const StaffScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StaffProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('List Petugas'),
        leading: const SizedBox(),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: provider.streamStaff,
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
          encapFunction(
            () => provider.updateList(snapshot.data?.docs),
          );

          return ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: snapshot.data?.docs.length ?? 0,
            physics: const ClampingScrollPhysics(),
            separatorBuilder: (_, i) => 5.verticalSpace,
            itemBuilder: (context, i) {
              final data = snapshot.data!.docs[i];

              return StaffItem(
                name: data['nama'] ?? '-',
                platNumber: data['plat'] ?? '',
                tapEdit: () {
                  provider.tapActionStaff(
                    context: context,
                    isEdit: true,
                    name: data['nama'] ?? '-',
                    plat: data['plat'] ?? '',
                    id: data['id'] ?? '',
                  );
                },
                tapDelete: () {
                  provider.doDeleteData(
                    id: data['id'],
                    context: context,
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.small(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          provider.tapActionStaff(context: context, isEdit: false);
        },
      ),
    );
  }
}
