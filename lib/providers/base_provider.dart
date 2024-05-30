import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BaseProvider extends ChangeNotifier {
  int index = 0;

  /// all user
  void changeIndex(int value) {
    index = value;
    notifyListeners();
  }
}
