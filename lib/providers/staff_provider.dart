import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trashgrab/firebase_options.dart';
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
            nama: item['username'] as String? ?? '',
          ),
        )
        .toList();
    notifyListeners();
  }

  void initRefresh() {
    streamStaff = _db.collection('users').snapshots();
    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? streamStaff;

  final _db = FirebaseFirestore.instance;

  void tapActionStaff({
    required BuildContext context,
    required bool isEdit,
    String? name,
    String? email,
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
          email: email,
          id: id,
        ),
      ),
    );
  }

  void doEditData({
    required String name,
    required String plat,
    // required String email,
    required String id,
    required BuildContext context,
  }) async {
    DialogHelper.showLoadingDialog(context);
    try {
      await _db.collection('users').doc(id).update({
        'id': id,
        'username': name,
        'plat': plat,
      });
      pop(context);
      pop(context);
    } catch (_) {
      pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Action Failed')),
      );
    }
  }

  void doCreateData({
    required String name,
    required String email,
    required String password,
    required String plat,
    required BuildContext context,
  }) async {
    DialogHelper.showLoadingDialog(context);
    try {
      final credential = await FirebaseAuth.instanceFor(
        app: await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
          name: 'temporary-staff',
        ),
      ).createUserWithEmailAndPassword(email: email, password: password);
      await _db.collection('users').doc(credential.user?.uid).set({
        'id': credential.user?.uid,
        'username': name,
        'email': email,
        'role': 'staff',
        'password': password,
        'address': '',
        'phone': '',
        'photo': '',
        'plat': plat,
      });
      pop(context);
      pop(context);
    } catch (_) {
      pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Action Failed')),
      );
    }
  }

  void doDeleteData({
    required String id,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    DialogHelper.showLoadingDialog(context);
    final credential = await FirebaseAuth.instanceFor(
      app: await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
        name: 'temporary-staff',
      ),
    ).signInWithEmailAndPassword(email: email, password: password);
    await credential.user?.delete();
    await _db.collection('users').doc(id).delete();
    pop(context);
  }
}
