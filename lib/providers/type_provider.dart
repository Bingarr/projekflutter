import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trashgrab/screens/add_update_type_screen.dart';
import 'package:trashgrab/screens/detail_sampah_screen.dart';
import 'package:trashgrab/utils/function.dart';
import 'package:trashgrab/widgets/dialog_helper.dart';

class TypeProvider extends ChangeNotifier {
  final _authId = FirebaseAuth.instance.currentUser?.uid;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamType =
      FirebaseFirestore.instance.collection('type').snapshots();

  /// only admin
  void tapActionType({
    required BuildContext context,
    required bool isEdit,
    String? name,
    String? image,
    String? harga,
    String? id,
  }) {
    clearLocaleImage();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddUpdateTypeScreen(
          isEdit: isEdit,
          name: name,
          image: image,
          harga: harga,
          id: id,
        ),
      ),
    );
  }

  final _db = FirebaseFirestore.instance;

  File? file;

  void clearLocaleImage() {
    file = null;
    notifyListeners();
  }

  /// only admin
  void updateFile(File? value) {
    file = value;
    notifyListeners();
  }

  /// only admin
  void doEditData({
    String? name,
    String? image,
    String? harga,
    String? id,
    required BuildContext context,
  }) async {
    DialogHelper.showLoadingDialog(context);
    String imageUrlFix = '';
    if (file != null) {
      final url = await uploadImage(file!);
      if (url == null) {
        pop(context);
        doSnackbar(
          context,
          'Getting error when upload image',
        );
        return;
      } else {
        imageUrlFix = url;
        await deleteOldUrlImage(image ?? '');
      }
    }
    try {
      await _db.collection('type').doc(id).update({
        'id': id,
        'name': name,
        'image': file == null ? image : imageUrlFix,
        'harga': int.parse(harga!),
      });
      pop(context);
      pop(context);
    } catch (_) {
      pop(context);
      doSnackbar(
        context,
        'Getting errors!',
      );
    }
  }

  /// only admin
  void doCreateData({
    String? name,
    String? harga,
    String? id,
    required BuildContext context,
  }) async {
    DialogHelper.showLoadingDialog(context);
    final url = await uploadImage(file!);
    if (url == null) {
      pop(context);
      doSnackbar(
        context,
        'Getting error when upload image',
      );
      return;
    }
    try {
      await _db.collection('type').doc(id).set({
        'id': id,
        'name': name,
        'image': url,
        'list_id': [],
        'harga': int.parse(harga!),
      });
      pop(context);
      pop(context);
    } catch (_) {
      pop(context);
      doSnackbar(
        context,
        'Getting errors!',
      );
    }
  }

  /// only admin
  void doDeleteData({
    required String id,
    required String image,
    required BuildContext context,
  }) async {
    DialogHelper.showLoadingDialog(context);
    await _db.collection('type').doc(id).delete();
    await deleteOldUrlImage(image);
    pop(context);
    pop(context);
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>>? listTye;

  /// only user
  void updateList(List<QueryDocumentSnapshot<Map<String, dynamic>>>? value) {
    listTye = value;
    notifyListeners();
  }

  /// only user
  Future<bool> tapDetailType({
    required BuildContext context,
    required String nama,
    required String image,
    required String harga,
    required String idType,
    required List<dynamic> listId,
  }) async {
    clearLocaleImage();
    final isLike = listId.any((item) => item == _authId);
    changeStatusLike(isLike);
    bool? data = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailSampahScreen(
          nama: nama,
          imageUrl: image,
          harga: harga,
          idType: idType,
        ),
      ),
    );
    return data ?? false;
  }

  bool statusLike = false;

  /// only user
  void changeStatusLike(bool value) {
    statusLike = value;
    notifyListeners();
  }

  /// only user
  void likeOrUnlikeType(String id) async {
    final snapshot = await _db.collection('type').doc(id).get();
    List<dynamic> list = snapshot['list_id'] ?? <dynamic>[];
    bool idFound = list.any((item) => item == _authId);

    /// is true
    /// meaning do unlike
    if (idFound) {
      changeStatusLike(false);
      list.removeWhere((item) => item == _authId);
      await _db.collection('type').doc(id).update({
        'list_id': list,
      });
    } else {
      changeStatusLike(true);
      list.add(_authId);
      await _db.collection('type').doc(id).update({
        'list_id': list,
      });
    }
  }
}
