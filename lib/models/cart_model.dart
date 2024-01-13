import 'dart:convert';

class CartItem {
  CartItem(
      {this.id,
      required this.title,
      required this.image,
      required this.price,
      required this.quantity});
  String? id;
  late final String title;
  late final String image;
  late final double price;
  late final int quantity;

  CartItem.fromMap({String? cartId, required Map<String, dynamic> map}) {
    id = cartId;
    title = map['title'];
    image = map['image'];
    price = map['price'];
    quantity = map['quantity'];
  }

  String toJson() {
    return json.encode({
      'title': title,
      'image': image,
      'price': price,
      'quantity': quantity,
    });
  }
}
