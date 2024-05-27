import 'package:intl/intl.dart';

extension DateTimeX on DateTime? {
  String toFormatGeneralDate() {
    if (this == null) {
      return 'Pilih Tanggal';
    }
    try {
      DateFormat dateFormat = DateFormat('dd MMM yyyy', 'id');

      return dateFormat.format(this!);
    } catch (_) {
      return '-';
    }
  }

  String toFormatGeneralDateTime() {
    if (this == null) {
      return 'Pilih Tanggal';
    }
    try {
      DateFormat dateFormat = DateFormat('dd MMM yyyy HH:mm', 'id');

      return dateFormat.format(this!);
    } catch (_) {
      return '-';
    }
  }

  String toFormatDateParamsFull() {
    if (this == null) {
      return 'Pilih Tanggal';
    }
    try {
      DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss ', 'id');

      return dateFormat.format(this!);
    } catch (_) {
      return '-';
    }
  }
}

extension StringDate on String? {
  DateTime toFormatDateToDate() {
    if (this == null) {
      return DateTime.now();
    }
    try {
      DateTime date = DateFormat("yyyy-MM-dd HH:mm:ss", 'id').parse(this!);

      return date;
    } catch (_) {
      return DateTime.now();
    }
  }
}

extension StringTimeX on String? {
  String toFormatDate() {
    if (this == null) {
      return '-';
    }
    try {
      DateTime tempDate = DateFormat("yyyy-MM-dd HH:mm:ss", 'id').parse(this!);

      return tempDate.toFormatGeneralDate();
    } catch (_) {
      return '-';
    }
  }
  String toFormatDateTime() {
    if (this == null) {
      return '-';
    }
    try {
      DateTime tempDate = DateFormat("yyyy-MM-dd HH:mm:ss", 'id').parse(this!);

      return tempDate.toFormatGeneralDateTime();
    } catch (_) {
      return '-';
    }
  }
}
