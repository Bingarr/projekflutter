import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashgrab/providers/activty_provider.dart';
import 'package:trashgrab/providers/auth_provider.dart';
import 'package:trashgrab/providers/transaction_provider.dart';
import 'package:trashgrab/utils/function.dart';
import 'package:trashgrab/utils/hive/role_hive_service.dart';
import 'package:trashgrab/utils/space_extension.dart';
import 'package:trashgrab/widgets/transaction_item.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();
    final activityProvider = context.watch<ActivityProvider>();
    final authProvider = context.watch<MyAuthProvider>();

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 100,
              bottom: 20,
              left: 20,
              right: 20,
            ),
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.1, 0.5],
                colors: [
                  Color.fromARGB(255, 67, 136, 69),
                  Color.fromARGB(255, 21, 111, 24),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Have a nice day",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                5.verticalSpace,
                Text(
                  "Admin",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          20.verticalSpace,
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
            
                if (RoleHiveServices.getRole()?.role == 2) {
                  final data = snapshot.data?.docs
                      .where((item) => item['petugas_nama'] == authProvider.name)
                      .toList();
                  encapFunction(
                    () => provider.updateData(data),
                  );
            
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: provider.data.length,
                    padding: const EdgeInsets.all(5),
                    separatorBuilder: (_, i) => 8.verticalSpace,
                    itemBuilder: (_, i) {
                      final data = provider.data[i];
            
                      return TransactionItem(
                        id: data['id'] as String? ?? '',
                        status: data['status'] as String? ?? '',
                        nama: data['user_nama'] as String? ?? '',
                        harga: data['total'] as int? ?? 0,
                        // doReject: () {
                        //   provider.doRejectData(
                        //     context: context,
                        //     id: data['id'] as String? ?? '',
                        //     onTap: () => activityProvider.changeStatusDisplayUser(
                        //       uidUserTarget: data['user_id'] as String? ?? '',
                        //       context: context,
                        //       block: false,
                        //     ),
                        //   );
                        // },
                        // doApprove: () {
                        //   provider.triggerButton(
                        //     context: context,
                        //     id: data['id'] as String? ?? '',
                        //     onTap: () => activityProvider.changeStatusDisplayUser(
                        //       uidUserTarget: data['user_id'] as String? ?? '',
                        //       context: context,
                        //       status: true,
                        //       desc:
                        //           'Menuju ke lokasi - ${provider.pickedStaff?.nama}',
                        //     ),
                        //   );
                        // },
                        doDone: () {
                          provider.doDoneTransaction(
                            context: context,
                            id: data['id'] as String? ?? '',
                            onTap: () => activityProvider.changeStatusDisplayUser(
                              uidUserTarget: data['user_id'] as String? ?? '',
                              context: context,
                              block: false,
                              status: false,
                            ),
                          );
                        },
                      );
                    },
                  );
                } else {
                  final data = snapshot.data?.docs;
                  encapFunction(
                    () => provider.updateData(data),
                  );
            
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: provider.data.length,
                    padding: const EdgeInsets.all(5),
                    separatorBuilder: (_, i) => 8.verticalSpace,
                    itemBuilder: (_, i) {
                      final data = provider.data[i];
            
                      return TransactionItem(
                        id: data['id'] as String? ?? '',
                        status: data['status'] as String? ?? '',
                        nama: data['user_nama'] as String? ?? '',
                        harga: data['total'] as int? ?? 0,
                        doReject: () {
                          provider.doRejectData(
                            context: context,
                            id: data['id'] as String? ?? '',
                            onTap: () => activityProvider.changeStatusDisplayUser(
                              uidUserTarget: data['user_id'] as String? ?? '',
                              context: context,
                              block: false,
                            ),
                          );
                        },
                        doApprove: () {
                          provider.triggerButton(
                            context: context,
                            id: data['id'] as String? ?? '',
                            onTap: () => activityProvider.changeStatusDisplayUser(
                              uidUserTarget: data['user_id'] as String? ?? '',
                              context: context,
                              status: true,
                              desc:
                                  'Menuju ke lokasi - ${provider.pickedStaff?.nama}',
                            ),
                          );
                        },
                        doDone: () {
                          provider.doDoneTransaction(
                            context: context,
                            id: data['id'] as String? ?? '',
                            onTap: () => activityProvider.changeStatusDisplayUser(
                              uidUserTarget: data['user_id'] as String? ?? '',
                              context: context,
                              block: false,
                              status: false,
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
