import 'package:trashgrab/models/item_model.dart';
import 'package:flutter/foundation.dart';

class BookmarkProvider extends ChangeNotifier {
  int _count = 0;
  List<ItemModel> items = [];

  void addCount() {
    _count++;
    notifyListeners();
  }

  void decreaseCount() {
    _count--;
    notifyListeners();
  }

  void addItems(ItemModel data) {
    items.add(data);
    notifyListeners();
  }

  void removeItem(ItemModel data) {
    items.remove(data); // Hapus item dari list
    _count--; // Kurangi count
    notifyListeners();
  }

  int get count => _count;

  List<ItemModel> get itemsList {
    return items;
  }
}
