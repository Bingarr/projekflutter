import 'package:flutter/material.dart';

void closeKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

void pop(BuildContext context, {dynamic result}) =>
    Navigator.pop(context, result);


