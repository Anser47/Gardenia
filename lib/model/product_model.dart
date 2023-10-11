class ProductClass {
  String? name;
  String? price;
  String? quantity;
  String? description;
  String? category;
  String? imageUrl;
  ProductClass(
      {this.name,
      this.price,
      this.quantity,
      this.description,
      this.category,
      this.imageUrl});

  ProductClass.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    description = json['description'];
    category = json['category'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    data['quantity'] = quantity;
    data['description'] = description;
    data['category'] = category;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
