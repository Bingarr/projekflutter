import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trashgrab/models/item_model.dart';
import 'package:trashgrab/utils/extensions/date_format.dart';
import 'package:trashgrab/utils/extensions/string_extensions.dart';
import 'package:trashgrab/utils/function.dart';
import 'package:trashgrab/widgets/dialog_helper.dart';

/// only user
class BookmarkProvider extends ChangeNotifier {
  int _count = 0;
  final List<ItemModel> _items = [];

  void addItems(ItemModel data) {
    final index = findId(data.id);
    if (index != -1) {
      _items[index].totalItem++;
    } else {
      _count++;
      _items.add(data);
    }
    total += data.harga;
    notifyListeners();
  }

  void removeItem(ItemModel data) {
    final index = findId(data.id);
    if (_items[index].totalItem > 1) {
      _items[index].totalItem--;
    } else {
      _count--;
      _items.removeWhere((item) => item.id == data.id);
    }
    total -= data.harga;
    notifyListeners();
  }

  int getCountItem(String id) {
    final index = findId(id);
    if (index != -1) {
      return _items[index].totalItem;
    } else {
      return 0;
    }
  }

  int findId(String id) {
    try {
      return _items.indexWhere((item) => item.id == id);
    } catch (_) {
      return -1;
    }
  }

  int get count => _count;

  List<ItemModel> get itemsList => _items;

  DateTime? dateValue;

  Future<void> pickDateTime(BuildContext context) async {
    final data = await showDatePicker(
      context: context,
      initialDate: dateValue,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      selectableDayPredicate: (day) {
        return day.weekday == DateTime.monday ||
            day.weekday == DateTime.wednesday ||
            day.weekday == DateTime.friday ||
            day.weekday == DateTime.saturday;
      },
    );
    if (data != null) {
      changeDateValue(
        DateTime(
          data.year,
          data.month,
          data.day,
          DateTime.now().hour,
          DateTime.now().minute,
          DateTime.now().second,
        ),
      );
    }
  }

  void changeDateValue(DateTime date) {
    dateValue = date;
    notifyListeners();
  }

  int total = 0;

  final _db = FirebaseFirestore.instance;

  void createTransaction({
    required BuildContext context,
    required String alamat,
    required String nama,
    required Function onTap,
  }) async {
    closeKeyboard();
    DialogHelper.showLoadingDialog(context);
    final user = FirebaseAuth.instance.currentUser;
    final idTransaction = generateUuid();
    try {
      final snapshot =
          await _db.collection('activity_status').doc(user?.uid).get();
      if (snapshot.data()?['block_transaction'] ?? false) {
        pop(context);
        doSnackbar(context, 'Masih ada transaksi yang berlangsung');
        return;
      }
      await _db.collection('transaction').doc(idTransaction).set({
        'id': idTransaction,
        'user_id': user?.uid,
        'user_nama': nama.toTitleCase(),
        'petugas_nama': '',
        'petugas_plat': '',
        'alamat': alamat.toCapitalized(),
        'tanggal': dateValue.toFormatDateParamsFull(),
        'status': 'Menunggu',
        'barang': List<dynamic>.from(_items.map((x) => x.toJson())),
        'total': total,
      });
      await _db.collection('activity_status').doc(user?.uid).update({
        'desc': 'Penjemputan menunggu aksi dari admin',
        'block_transaction': true,
      });
      pop(context);
      _count = 0;
      _items.clear;
      total = 0;
      notifyListeners();
      pop(context);
      onTap();
    } catch (_) {
      pop(context);
      doSnackbar(context, 'Terjadi kesalahan');
    }
  }
}
