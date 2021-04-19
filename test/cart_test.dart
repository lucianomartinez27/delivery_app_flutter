import 'package:delivery_app/models/cart.dart';
import 'package:delivery_app/models/product.dart';
import 'package:test/test.dart';

main() {
  group("Cart", () {
    test("Cart has no products when it is created", () {
      Cart cart = Cart();
      assert(!cart.hasProducts());
    });

    test("Product is added to a Cart correctly", () {
      Cart cart = Cart();
      Product iceCream = Product(name: 'Ice Cream', price: 10);

      cart.addProduct(iceCream);

      assert(cart.hasProducts());
      assert(cart.contains(iceCream));
    });
  });
}
