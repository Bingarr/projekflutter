import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

void closeKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

void pop(BuildContext context, {dynamic result}) =>
    Navigator.pop(context, result);

String generateUuid() => const Uuid().v4().replaceAll('-', '');

Future<XFile?> pickImage(ImageSource source) async {
  final imagePicker = ImagePicker();
  final pickedImage = await imagePicker.pickImage(
    source: source,
  );
  return pickedImage;
}

Future<void> deleteOldUrlImage(String url) async {
  try {
    final list = url.split('/');
    final fileName = list.last.split('.').first;
    final storage = FirebaseStorage.instance.ref();
    Reference imageRef = storage.child("images/$fileName");
    imageRef.delete();
  } catch (_) {}
}

Future<String?> uploadImage(File file) async {
  try {
    final _storageRef = FirebaseStorage.instance.ref();
    Reference dirImage = _storageRef.child('images');
    String uniqueFileName = file.path.split('/').last;
    Reference imageToUpload = dirImage.child(uniqueFileName);
    await imageToUpload.putFile(file);
    final data = await imageToUpload.getDownloadURL();
    return data;
  } catch (_) {
    return null;
  }
}

void encapFunction(dynamic onTap) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    onTap();
  });
}

void doSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}
