import 'dart:collection';
import 'package:delivery_app/models/product.dart';

class ProductShelf {
  Set<Product> _products = {};
  bool get isEmpty => _products.isEmpty;

  get allProducts => UnmodifiableListView(_products);

  void addProduct(Product productToAdd) {
    _products.add(productToAdd);
  }

  bool hasProduct(Product potentialProduct) {
    return _products.contains(potentialProduct);
  }
}
