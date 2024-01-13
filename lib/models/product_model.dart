import 'package:tezda/models/models.dart';

class Product {
  Product(
      {this.id,
      required this.title,
      required this.description,
      this.image,
      required this.price,
      this.category,
      this.rating});
  int? id;
  late final String title;
  late final String description;
  String? image;
  late final double price;
  String? category;
  Rating? rating;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      price: json['price'].toDouble(),
      category: json['category'] as String,
      // rating: Rating.fromJson(json['rating'])
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'image': image,
      'rating': rating
    };
  }

  @override
  String toString() {
    return '''{
      id: $id, 
      title: $title, 
      description: $description, 
      price: $price, 
      image: $image
      }''';
  }
}
