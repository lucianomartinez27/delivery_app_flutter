import 'package:delivery_app/models/bag.dart';
import 'package:delivery_app/models/product.dart';
import 'package:test/test.dart';

main() {
  Bag iceCreamBag;
  setUp(() {
    iceCreamBag = Bag.of(Product(name: "Ice Cream", price: 10));
  });

  test("An Bag is of a particular product ", () {
    expect(iceCreamBag.isOf("Ice Cream"), isTrue);
  });
  test("An Bag knows to what product belongs", () {
    expect(iceCreamBag.isOf("Snacks"), isFalse);
  });

  test("When a bag of a product is created the total of products is zero", () {
    expect(iceCreamBag.total, equals(0));
  });

  test("The total items  of a item can be increased", () {
    iceCreamBag.addItem();
    expect(iceCreamBag.total, equals(1));
  });

  test("can not be removed items when the bag is empty", () {
    expect(() => iceCreamBag.removeItem(), throwsRangeError);
  });

  test("Item of a bag can be removed", () {
    iceCreamBag.addItem();
    iceCreamBag.addItem();
    expect(iceCreamBag.total, equals(2));
    iceCreamBag.removeItem();
    expect(iceCreamBag.total, equals(1));
  });

  test("Bag has no items when it is created", () {
    expect(iceCreamBag.hasItems, isFalse);
  });

  test("Bag has items when are added to it", () {
    iceCreamBag.addItem();
    expect(iceCreamBag.hasItems, isTrue);
  });
}
