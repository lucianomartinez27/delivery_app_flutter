import 'package:delivery_app/models/market.dart';
import 'package:delivery_app/models/product_shelf.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  Market market;

  setUp(() {
    market = Market();
  });

  test("Market has Shelf of products", () {
    market.addShelf(ProductShelf());
    expect(market.hasShelfOf('General'), isTrue);
  });

  test("Market does not include not added Shelf ", () {
    expect(market.hasShelfOf('General'), isFalse);
  });

  test("Can not add two shelf with the same category", () {
    market.addShelf(ProductShelf.of('Bazar'));
    expect(() => market.addShelf(ProductShelf.of('Bazar')), throwsException);
  });
}
