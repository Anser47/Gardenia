class OrderModel {
  String? id;
  String? status;
  String? productName;
  String? quantity;
  String? totalPrice;
  String? description;
  String? category;
  String? imageUrl;
  OrderModel({
    this.id,
    this.status,
    this.productName,
    this.quantity,
    this.totalPrice,
    this.category,
    this.description,
    this.imageUrl,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    productName = json['productName'];
    quantity = json['quantity'];
    totalPrice = json['totalPrice'];
    category = json['category'];
    description = json['description'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['productName'] = productName;
    data['quantity'] = quantity;
    data['totalPrice'] = totalPrice;
    data['category'] = category;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
