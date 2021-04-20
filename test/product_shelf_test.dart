import 'package:delivery_app/models/product.dart';
import 'package:delivery_app/models/product_shelf.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group("Product Shelf", () {
    ProductShelf shelf;
    Product iceCream;
    Product snack;
    setUp(() {
      shelf = ProductShelf();
      iceCream = Product(name: 'Ice Cream', price: 10);
      snack = Product(name: "Snacks", price: 5);
    });
    test("Shelf is empty when it's created", () {
      assert(shelf.isEmpty);
    });

    test("A product can be added to the shelf", () {
      shelf.addProduct(iceCream);
      assert(!shelf.isEmpty);
    });

    test("A shelf can not contains the same product twice", () {
      shelf.addProduct(iceCream);
      shelf.addProduct(snack);
      shelf.addProduct(iceCream);
      expect(shelf.allProducts.length, 2);
      assert(shelf.hasProduct(iceCream));
      assert(shelf.hasProduct(snack));
    });
  });
}
