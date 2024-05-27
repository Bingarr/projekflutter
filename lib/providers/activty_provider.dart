import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ActivityProvider extends ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamActivity =
      FirebaseFirestore.instance
          .collection('activity_status')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .snapshots();

  /// all user
  Future<void> changeStatusDisplayUser({
    String? uidUserTarget,
    String? desc,
    bool? status,
    bool? block,
    required BuildContext context,
  }) async {
    try {
      await _db
          .collection('activity_status')
          .doc(
            uidUserTarget ?? _firebaseAuth.currentUser?.uid,
          )
          .update({
        if (status != null) 'status_display': status,
        if (desc != null) 'desc': desc,
        if (block != null) 'block_transaction': block,
      });
    } catch (_) {
      changeStatusDisplayUser(
        status: status,
        context: context,
        uidUserTarget: uidUserTarget,
      );
    }
  }
}
