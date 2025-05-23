import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product.dart';

class ProductService {
  final CollectionReference _productsCollection = FirebaseFirestore.instance
      .collection('products');

  // Get all products
  Stream<List<Product>> getProducts() {
    return _productsCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => Product.fromFirestore(doc))
              .toList();
        });
  }

  // Get a single product
  Future<Product?> getProduct(String id) async {
    final doc = await _productsCollection.doc(id).get();
    if (doc.exists) {
      return Product.fromFirestore(doc);
    }
    return null;
  }

  // Add a new product
  Future<String> addProduct(Product product) async {
    final docRef = await _productsCollection.add(product.toFirestore());
    return docRef.id;
  }

  // Update a product
  Future<void> updateProduct(String id, Product product) async {
    await _productsCollection.doc(id).update(product.toFirestore());
  }

  // Delete a product
  Future<void> deleteProduct(String id) async {
    await _productsCollection.doc(id).delete();
  }
}
