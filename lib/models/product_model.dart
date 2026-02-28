class ProductModel {
  String? id;
  String? name;
  double? price;
  String? details;
  String? imageUrl;
  ProductModel({
    this.id,
    required this.name,
    required this.details,
    required this.price,
    required this.imageUrl,
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'details': details,
      'price': price,
      'imageUrl': imageUrl,
      'createdAt': DateTime.now(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map, String documentId) {
    return ProductModel(
      id: documentId,
      name: map['name'] ?? '',
      details: map['details'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}
