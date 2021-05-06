import 'dart:collection';
import 'package:delivery_app/models/product.dart';
import 'package:flutter/foundation.dart';

class ProductShelf extends ChangeNotifier {
  Set<Product> _products = {};
  String category = 'General';
  ProductShelf();
  ProductShelf.of(String productsCategory) : category = productsCategory;

  bool get isEmpty => _products.isEmpty;

  get allProducts => UnmodifiableListView(_products);

  void addProduct(Product productToAdd) {
    if (!hasProduct(productToAdd)) {
      _products.add(productToAdd);
      notifyListeners();
    }
  }

  bool hasProduct(Product potentialProduct) {
    return _products
        .where((product) => product.isNamed(potentialProduct.name))
        .isNotEmpty;
  }

  isCategorizedAs(String productsCategory) => productsCategory == category;
}
