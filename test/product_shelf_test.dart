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
      expect(shelf.isEmpty, isTrue);
    });

    test("A product can be added to the shelf", () {
      shelf.addProduct(iceCream);
      expect(shelf.isEmpty, isFalse);
    });

    test("A shelf can not contains the same product twice", () {
      shelf.addProduct(iceCream);
      shelf.addProduct(snack);
      shelf.addProduct(Product(name: "Ice Cream", price: 10));
      expect(shelf.allProducts.length, equals(2));
      expect(shelf.hasProduct(iceCream), isTrue);
      expect(shelf.hasProduct(snack), isTrue);
    });

    test("Shelf with no explict category is categorized as General", () {
      expect(shelf.isCategorizedAs('General'), isTrue);
    });

    test("Product Shelf can be categorized", () {
      ProductShelf bazarShelf = ProductShelf.of('Bazar');
      expect(bazarShelf.isCategorizedAs('General'), isFalse);
      expect(bazarShelf.isCategorizedAs('Bazar'), isTrue);
    });
  });
}
