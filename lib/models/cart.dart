import 'package:delivery_app/models/product.dart';

class Cart {
  List<Product> productsList = [];

  get totalPrice => productsList
      .map((product) => product.price)
      .fold(0, (previousPrice, currentPrice) => previousPrice + currentPrice);

  bool hasProducts() {
    return productsList.isNotEmpty;
  }

  void addProduct(Product productToAdd) {
    productsList.add(productToAdd);
  }

  bool contains(Product potentialProduct) {
    return productsList.contains(potentialProduct);
  }

  int totalOf(Product potentialProduct) {
    return productsList.where((element) => element == potentialProduct).length;
  }
}
