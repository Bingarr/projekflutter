import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trashgrab/screens/base_screen.dart';
import 'package:trashgrab/screens/welcome_screen.dart';
import 'package:trashgrab/utils/function.dart';
import 'package:trashgrab/utils/hive/role_hive_service.dart';
import 'package:trashgrab/widgets/dialog_helper.dart';

class MyAuthProvider extends ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  final _storageRef = FirebaseStorage.instance.ref();

  /// all user
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
      initRefresh();
      notifyListeners();
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

  Map<String, dynamic>? data;

  void updateData(Map<String, dynamic>? value) {
    data = value;
    notifyListeners();
  }

  /// all user
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
      await _db
          .collection('activity_status')
          .doc(userCredentials.user?.uid)
          .set({
        'desc': [],
        'status_display': false,
        'block_transaction': false,
      });
      await changeRoleUser(userCredentials.user?.uid);
      pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BaseScreen(),
        ),
      );
      initRefresh();
      notifyListeners();
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

  void initRefresh() {
    streamProfile =
        _db.collection('users').doc(_firebaseAuth.currentUser?.uid).snapshots();
    notifyListeners();
  }

  /// all user
  Stream<DocumentSnapshot<Map<String, dynamic>>>? streamProfile;

  /// all user
  Future<void> changeRoleUser(String? id) async {
    final data = await _db.collection("users").doc(id).get();
    if (data.data()?['role'] != null) {
      if (data.data()?['role'] == 'admin') {
        RoleHiveServices.setRole(1);
      } else {
        RoleHiveServices.setRole(0);
      }
    }
    notifyListeners();
  }

  /// all user
  void doLogout(BuildContext context, Function() func) async {
    await _firebaseAuth.signOut();
    RoleHiveServices.deleteRole();
    notifyListeners();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const WelcomeScreen(),
      ),
    );
    func();
  }

  /// all user
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
      await _db.collection('users').doc(userId).update({
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

  /// all user
  void clearLocalImage() {
    localImage = null;
    notifyListeners();
  }

  /// all user
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

  /// all user
  void deleteOldPhoto(String fileName) {
    final imagesRef = _storageRef.child("images/$fileName");
    imagesRef.delete();
    notifyListeners();
  }
}
