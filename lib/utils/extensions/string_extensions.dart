import 'package:intl/intl.dart';

extension StringCasingExtension on String? {
  String toCapitalized() {
    if (this == null) {
      return '';
    } else {
      return '${this![0].toUpperCase()}${this!.substring(1).toLowerCase()}';
    }
  }

  String toTitleCase() {
    if (this == null) {
      return '';
    }
    return this!
        .replaceAll(RegExp(' +'), ' ')
        .split(' ')
        .map((str) => str.toCapitalized())
        .join(' ');
  }

  String formatNumber() {
    if (this == null) {
      return '0';
    }
    try {
      double number = double.parse(this!);
      String value = NumberFormat("#,##0", "id_ID").format(number);
      return 'Rp ${value.replaceAll(',', '.')}/kg';
    } catch (e) {
      return this!;
    }
  }
}

extension NumberCasingExtension on num? {
  String formatNumber() {
    if (this == null) {
      return '0';
    }
    try {
      double number = (this ?? 0).toDouble();
      String value = NumberFormat("#,##0", "id_ID").format(number);
      return 'Rp ${value.replaceAll(',', '.')}/kg';
    } catch (e) {
      return toString();
    }
  }
  String formatNumber2() {
    if (this == null) {
      return '0';
    }
    try {
      double number = (this ?? 0).toDouble();
      String value = NumberFormat("#,##0", "id_ID").format(number);
      return 'Rp ${value.replaceAll(',', '.')}';
    } catch (e) {
      return toString();
    }
  }
}
