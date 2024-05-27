class ItemModel {
  String nama;
  int harga;
  String image;
  String id;
  int totalItem;

  ItemModel({
    required this.nama,
    required this.harga,
    required this.image,
    required this.id,
    required this.totalItem,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      nama: json['nama'] ?? '',
      harga: json['harga'] ?? '',
      image: json['image'] ?? '',
      id: json['id'] ?? '',
      totalItem: json['total_item'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'harga': harga,
      'image': image,
      'id': id,
      'total_item': totalItem,
    };
  }
}
