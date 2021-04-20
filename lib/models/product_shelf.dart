import 'dart:collection';
import 'package:delivery_app/models/product.dart';
import 'package:flutter/foundation.dart';

class ProductShelf extends ChangeNotifier {
  Set<Product> _products = {};
  bool get isEmpty => _products.isEmpty;

  get allProducts => UnmodifiableListView(_products);

  void addProduct(Product productToAdd) {
    if (thereIsNoProduct(productToAdd)) {
      _products.add(productToAdd);
      notifyListeners();
    }
  }

  bool thereIsNoProduct(Product productToAdd) {
    return _products
        .where((element) => element.isNamed(productToAdd.name))
        .isEmpty;
  }

  bool hasProduct(Product potentialProduct) {
    return _products.contains(potentialProduct);
  }
}
