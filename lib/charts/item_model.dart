class ItemModel {
  String title;
  String subTitle;
  bool isFavorite;

  ItemModel({
    required this.title,
    required this.subTitle,
    this.isFavorite = false,
  }); // Inisialisasi default dengan false
}
