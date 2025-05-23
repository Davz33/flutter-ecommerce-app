import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final int stock;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.stock,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0.0).toDouble(),
      imageUrl: data['imageUrl'] ?? '',
      stock: data['stock'] ?? 0,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'stock': stock,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}
