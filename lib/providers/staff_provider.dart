import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trashgrab/models/staff_model.dart';
import 'package:trashgrab/screens/add_update_staff_screen.dart';
import 'package:trashgrab/utils/function.dart';
import 'package:trashgrab/widgets/dialog_helper.dart';

/// only admin
class StaffProvider extends ChangeNotifier {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> listStaff = [];
  List<StaffModel> listRadio = [];

  void updateList(List<QueryDocumentSnapshot<Map<String, dynamic>>>? value) {
    listStaff = value ?? [];
    listRadio = listStaff
        .map(
          (item) => StaffModel(
            id: item['id'] as String? ?? '',
            plat: item['plat'] as String? ?? '',
            nama: item['nama'] as String? ?? '',
          ),
        )
        .toList();
    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamStaff =
      FirebaseFirestore.instance.collection('staffs').snapshots();

  final _db = FirebaseFirestore.instance;

  void tapActionStaff({
    required BuildContext context,
    required bool isEdit,
    String? name,
    String? plat,
    String? id,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddUpdateStaffScreen(
          isEdit: isEdit,
          name: name,
          plat: plat,
          id: id,
        ),
      ),
    );
  }

  void doEditData({
    required String name,
    required String plat,
    required String id,
    required BuildContext context,
  }) async {
    DialogHelper.showLoadingDialog(context);
    await _db.collection('staffs').doc(id).update({
      'id': id,
      'nama': name,
      'plat': plat,
    });
    pop(context);
    pop(context);
  }

  void doCreateData({
    required String name,
    required String plat,
    required String id,
    required BuildContext context,
  }) async {
    DialogHelper.showLoadingDialog(context);
    await _db.collection('staffs').doc(id).set({
      'id': id,
      'nama': name,
      'plat': plat,
    });
    pop(context);
    pop(context);
  }

  void doDeleteData({
    required String id,
    required BuildContext context,
  }) async {
    DialogHelper.showLoadingDialog(context);
    await _db.collection('staffs').doc(id).delete();
    pop(context);
  }
}
