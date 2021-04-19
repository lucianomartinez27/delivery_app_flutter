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
  });
}
