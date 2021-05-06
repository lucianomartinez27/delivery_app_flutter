import 'package:delivery_app/models/market.dart';
import 'package:delivery_app/models/product.dart';
import 'package:delivery_app/models/product_shelf.dart';

class FirebaseRecepcionist {
  ProductShelf loadProducts(List<dynamic> products,
      {ProductShelf shelfToLoad}) {
    if (shelfToLoad == null) {
      shelfToLoad = ProductShelf();
    }

    products.forEach((product) {
      shelfToLoad
          .addProduct(Product(name: product['name'], price: product['price']));
    });
    return shelfToLoad;
  }

  Market addShelf(List<Map<String, dynamic>> categories) {
    Market market = Market();

    categories.forEach((category) {
      ProductShelf shelf = ProductShelf.of(category['name']);
      loadProducts(category['products'], shelfToLoad: shelf);
      market.addShelf(shelf);
    });

    return market;
  }
}
