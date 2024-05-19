import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trashgrab/login_checker.dart';
import 'package:trashgrab/models/role_enum.dart';
import 'package:trashgrab/screens/base_screen.dart';
import 'package:trashgrab/utils/function.dart';
import 'package:trashgrab/utils/hive/role_hive_service.dart';
import 'package:trashgrab/widgets/dialog_helper.dart';

class MyAuthProvider extends ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  final _storageRef = FirebaseStorage.instance.ref();

  void login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Fill the empty field")),
      );
      return;
    }
    DialogHelper.showLoadingDialog(context);
    try {
      final userCredentials = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await changeRoleUser(userCredentials.user?.uid);
      pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BaseScreen()),
      );
    } on FirebaseAuthException catch (e) {
      List<String> err = e.toString().split('] ');
      String errText;
      if (err.length > 1) {
        errText = err.last;
      } else if (err.length == 1) {
        errText = err.first;
      } else {
        errText = "Authentication Failed!";
      }
      log(errText);
      pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errText)),
      );
    }
  }

  void signup({
    required BuildContext context,
    required String email,
    required String username,
    required String password,
  }) async {
    DialogHelper.showLoadingDialog(context);
    try {
      final userCredentials =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _db.collection('users').doc(userCredentials.user?.uid).set({
        'username': username,
        'email': email,
        'role': 'user',
        'password': password,
        'address': '',
        'phone': '',
        'photo': '',
      });
      await changeRoleUser(userCredentials.user?.uid);
      pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BaseScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      List<String> err = e.toString().split('] ');
      String errText;
      if (err.length > 1) {
        errText = err.last;
      } else if (err.length == 1) {
        errText = err.first;
      } else {
        errText = "Registration Failed!";
      }
      log(errText);
      pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errText)),
      );
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamProfile =
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .snapshots();

  Future<void> changeRoleUser(String? id) async {
    final data = await _db.collection("users").doc(id).get();
    if (data.data()?['role'] != null) {
      if (data.data()?['role'] == 'admin') {
        RoleHiveServices.setRole(RoleUserCurrent.admin);
      } else {
        RoleHiveServices.setRole(RoleUserCurrent.user);
      }
    }
  }

  void doLogout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    RoleHiveServices.deleteRole();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginChecker(),
      ),
    );
  }

  Future<void> editProfile({
    required String oldPhoto,
    required String phone,
    required String username,
    required String address,
    required BuildContext context,
  }) async {
    DialogHelper.showLoadingDialog(context);
    final userId = _firebaseAuth.currentUser?.uid;
    String imageUrl = '';
    if (localImage != null) {
      try {
        Reference dirImage = _storageRef.child('images');
        String uniqueFileName = localImage!.path.split('/').last;
        Reference imageToUpload = dirImage.child(uniqueFileName);
        await imageToUpload.putFile(localImage!);
        imageUrl = await imageToUpload.getDownloadURL();
        if (oldPhoto.isNotEmpty) {
          final list = oldPhoto.split('/');
          final fileName = list.last.split('.').first;
          deleteOldPhoto(fileName);
        }
      } on FirebaseException catch (e) {
        pop(context);
        log(e.toString());
        String err = 'Gagal Mengubah Photo Profil';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(err),
          ),
        );
        return;
      }
    }
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'username': username,
        'address': address,
        'phone': phone,
        if (imageUrl.isNotEmpty) 'photo': imageUrl,
      });
      clearLocalImage();
      pop(context);
      pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data berhasil di ubah!'),
        ),
      );
    } catch (e) {
      pop(context);
      log(e.toString());
      return;
    }
    notifyListeners();
  }

  File? localImage;

  void clearLocalImage() {
    localImage = null;
    notifyListeners();
  }

  void pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage == null) {
      return;
    }
    localImage = File(pickedImage.path);
    notifyListeners();
  }

  void deleteOldPhoto(String fileName) {
    final storageRef = _storageRef;
    final imagesRef = storageRef.child("images/$fileName");
    imagesRef.delete();
    notifyListeners();
  }
}
