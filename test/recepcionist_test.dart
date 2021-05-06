import 'package:delivery_app/models/firebase_recepcionist.dart';
import 'package:delivery_app/models/product.dart';
import 'package:delivery_app/models/product_shelf.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  FirebaseRecepcionist recepcionist;
  setUp(() {
    recepcionist = FirebaseRecepcionist();
  });

  test('When there are not products the recepcionist return an empty Shelf',
      () {
    List<Map<String, dynamic>> products = [];

    ProductShelf productShelf = recepcionist.loadProducts(products);
    expect(productShelf.isEmpty, isTrue);
  });

  test(
      'When there are  products the recepcionist return Shelf with the products',
      () {
    List<Map<String, dynamic>> products = [];
    Map<String, dynamic> iceCream =
        Map.from({'price': 10, 'name': 'Ice Cream'});
    Map<String, dynamic> snacks = Map.from({'price': 10, 'name': 'Snacks'});
    products.add(iceCream);
    products.add(snacks);

    ProductShelf productShelf = recepcionist.loadProducts(products);
    expect(productShelf.isEmpty, isFalse);
    expect(
        productShelf.hasProduct(Product(name: 'Ice Cream', price: 10)), isTrue);
    expect(productShelf.hasProduct(Product(name: 'Snacks', price: 10)), isTrue);
  });
}
