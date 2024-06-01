import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trashgrab/models/staff_model.dart';
import 'package:trashgrab/utils/extensions/date_format.dart';
import 'package:trashgrab/utils/function.dart';
import 'package:trashgrab/widgets/dialog_helper.dart';
import 'package:trashgrab/widgets/staff_bottom_sheet.dart';

class TransactionProvider extends ChangeNotifier {
  final firebaseAuth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  void initRefresh() {
    streamAll = _db.collection('transaction').snapshots();
    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? streamAll;

  List<QueryDocumentSnapshot<Map<String, dynamic>>> data = [];

  void updateData(List<QueryDocumentSnapshot<Map<String, dynamic>>>? value) {
    data = value ?? [];
    data.sort((a, b) {
      return (b['tanggal'] as String?)
          .toFormatDateToDate()
          .compareTo((a['tanggal'] as String?).toFormatDateToDate());
    });
    
    notifyListeners();
  }

  /// only admin
  void doRejectData({
    required BuildContext context,
    required String id,
    required Future<void> Function() onTap,
  }) async {
    DialogHelper.showLoadingDialog(context);
    try {
      await _db.collection('transaction').doc(id).update({
        'status': 'Dibatalkan',
        'tanggal': DateTime.now().toFormatDateParamsFull(),
      });
      pop(context);
      onTap();
    } catch (e) {
      pop(context);
      doSnackbar(context, 'Terjadi Kesalahan');
    }
  }

  /// only admin
  void triggerButton({
    required BuildContext context,
    required String id,
    required Future<void> Function() onTap,
  }) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return StaffBottomSheet(
          tap: () => doSetDriver(context: context, id: id, onTap: onTap),
        );
      },
    );
  }

  StaffModel? pickedStaff;

  /// only admin
  void pickStaff(StaffModel? item) {
    pickedStaff = item;
    notifyListeners();
  }

  /// only admin
  void doSetDriver({
    required BuildContext context,
    required String id,
    required Future<void> Function() onTap,
  }) async {
    if (pickedStaff == null) return;
    DialogHelper.showLoadingDialog(context);
    try {
      await _db.collection('transaction').doc(id).update({
        'status': 'Dalam Perjalanan',
        if (pickedStaff != null) 'petugas_nama': pickedStaff?.nama,
        if (pickedStaff != null) 'petugas_plat': pickedStaff?.plat,
        'tanggal': DateTime.now().toFormatDateParamsFull(),
      });
      onTap();
      pop(context);
      pickStaff(null);
      pop(context);
    } catch (e) {
      pop(context);
      doSnackbar(context, 'Terjadi Kesalahan');
    }
  }

  /// only admin
  void doDoneTransaction({
    required BuildContext context,
    required String id,
    required Future<void> Function() onTap,
  }) async {
    DialogHelper.showLoadingDialog(context);
    try {
      await _db.collection('transaction').doc(id).update({
        'status': 'Selesai',
        'tanggal': DateTime.now().toFormatDateParamsFull(),
      });
      pop(context);
      onTap();
    } catch (e) {
      pop(context);
      doSnackbar(context, 'Terjadi Kesalahan');
    }
  }
}
