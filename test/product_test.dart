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

    test("Simple named product picture src is his name with the extension", () {
      Product phone = Product(name: "Phone", price: 10);
      expect(phone.takePicture, equals('phone.jpg'));
    });

    test("Product has a picture src with his name and underscore between words",
        () {
      Product iceCream = Product(name: "Ice Cream", price: 10);
      expect(iceCream.takePicture, equals('ice_cream.jpg'));
      Product withLargeName =
          Product(name: "Product with a large name", price: 4);
      expect(
          withLargeName.takePicture, equals("product_with_a_large_name.jpg"));
    });
  });
}
