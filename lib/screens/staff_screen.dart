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
          final data = snapshot.data?.docs
              .where((item) => item['role'] == 'staff')
              .toList();
          encapFunction(
            () => provider.updateList(data),
          );

          return ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: data?.length ?? 0,
            physics: const ClampingScrollPhysics(),
            separatorBuilder: (_, i) => 5.verticalSpace,
            itemBuilder: (context, i) {
              final finalData = data![i];

              return StaffItem(
                name: finalData['username'] ?? '-',
                platNumber: finalData['plat'] ?? '',
                tapEdit: () {
                  provider.tapActionStaff(
                    context: context,
                    isEdit: true,
                    name: finalData['username'] ?? '-',
                    plat: finalData['plat'] ?? '',
                    id: finalData['id'] ?? '',
                    email: finalData['email'] ?? '',
                  );
                },
                tapDelete: () {
                  provider.doDeleteData(
                    id: finalData['id'],
                    email: finalData['email'] ?? '',
                    password: finalData['password'] ?? '',
                    context: context,
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.small(
        heroTag: 'staff',
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
