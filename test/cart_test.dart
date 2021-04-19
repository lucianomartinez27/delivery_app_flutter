import 'package:delivery_app/models/cart.dart';
import 'package:delivery_app/models/product.dart';
import 'package:test/test.dart';

main() {
  group("Cart", () {
    Cart cart;
    Product iceCream;
    Product snacks;

    setUp(() {
      cart = Cart();
      iceCream = Product(name: 'Ice Cream', price: 10);
      snacks = Product(name: "Snack", price: 14);
    });
    test("Cart has no products when it is created", () {
      assert(!cart.hasProducts());
    });

    test("Product is added to a Cart correctly", () {
      cart.addProduct(iceCream);

      assert(cart.hasProducts());
      assert(cart.contains(iceCream));
    });

    test("Total price of an empty cart is zero", () {
      expect(cart.totalPrice, 0);
    });

    test("Prices of a cart are calculated correctly", () {
      cart.addProduct(iceCream);
      cart.addProduct(snacks);
      cart.addProduct(iceCream);

      int productsPrice = iceCream.price + iceCream.price + snacks.price;

      expect(cart.totalPrice, productsPrice);
    });

    test("Total of a product in an empry cart is zero", () {
      expect(cart.totalOf(iceCream), 0);
    });

    test("When products are added to a cart the total of them increases", () {
      cart.addProduct(snacks);
      expect(cart.totalOf(snacks), 1);

      cart.addProduct(snacks);
      cart.addProduct(iceCream);
      expect(cart.totalOf(snacks), 2);
      expect(cart.totalOf(iceCream), 1);
    });
  });
}
