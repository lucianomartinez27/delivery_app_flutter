import 'package:delivery_app/models/product.dart';
import 'package:delivery_app/models/product_shelf.dart';

class FirebaseRecepcionist {
  ProductShelf loadProducts(List<Map<String, dynamic>> products) {
    ProductShelf shelf = ProductShelf();
    products.forEach((product) {
      shelf.addProduct(Product(name: product['name'], price: product['price']));
    });
    return shelf;
  }
}
