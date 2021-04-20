import 'package:delivery_app/models/product.dart';
import 'package:flutter/foundation.dart';

class Cart extends ChangeNotifier {
  List<Product> productsList = [];

  get totalPrice => productsList
      .map((product) => product.price)
      .fold(0, (previousPrice, currentPrice) => previousPrice + currentPrice);

  bool hasProducts() {
    return productsList.isNotEmpty;
  }

  void addProduct(Product productToAdd) {
    notifyListeners();
    productsList.add(productToAdd);
  }

  bool contains(Product potentialProduct) {
    return productsList.contains(potentialProduct);
  }

  int totalOf(Product potentialProduct) {
    return productsList.where((element) => element == potentialProduct).length;
  }
}
