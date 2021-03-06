import 'package:delivery_app/models/cart.dart';
import 'package:delivery_app/models/bag.dart';
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
    test("A cart can be consulted for what types of products it has", () {
      cart.addProduct(snacks);
      cart.addProduct(snacks);
      cart.addProduct(iceCream);
      expect(cart.uniqueProducts, contains(iceCream));
      expect(cart.uniqueProducts, contains(snacks));
      expect(cart.uniqueProducts.length, equals(2));
    });

    test("A product can be added a certain ammount of times", () {
      cart.addProduct(iceCream, times: 3);
      expect(cart.totalOf(iceCream), equals(3));
      cart.addProduct(snacks, times: 0);
      expect(cart.totalOf(snacks), equals(0));
    });
    test("Products can be added by a bag", () {
      Bag bag = Bag.of(iceCream);
      bag.addItem();
      bag.addItem();
      cart.addBag(bag);
      expect(cart.totalOf(iceCream), equals(2));
      Bag anotherBag = Bag.of(snacks);

      cart.addBag(anotherBag);
      expect(cart.totalOf(snacks), equals(0));
    });
    test("Total price of a product is zero when it's not in the cart", () {
      expect(cart.totalPriceOf(iceCream), equals(0));
    });

    test("Cart calculates the total price of a product correctly", () {
      cart.addProduct(iceCream, times: 4);
      expect(cart.totalPriceOf(iceCream), equals(40));
    });
  });
}
