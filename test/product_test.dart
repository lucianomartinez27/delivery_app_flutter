import 'package:delivery_app/models/product.dart';
import 'package:test/test.dart';

main() {
  group("Product", () {
    test("Product can not be created without a name", () {
      expect(() {
        Product(name: '', price: 0);
      }, throwsA(TypeMatcher<InvalidNameError>()));
    });

    test("Product with no empty name can be created", () {
      Product product = Product(name: "Phone", price: 0);
      assert(product.isNamed("Phone"));
    });

    test("Product knows what is not his name", () {
      Product product = Product(name: "Phone", price: 0);
      assert(!product.isNamed("Banana"));
    });

    test("Product price can not be negative", () {
      expect(() {
        Product(name: 'Phone', price: -2);
      }, throwsArgumentError);
    });

    test("Product with price above zero can be created correctly", () {
      Product product = Product(name: "Phone", price: 10);
      assert(product.isPriced(10));
    });
    test("Product knows his price correctly", () {
      Product product = Product(name: "Phone", price: 0);
      assert(!product.isPriced(10));
      assert(product.isPriced(0));
    });
  });
}
