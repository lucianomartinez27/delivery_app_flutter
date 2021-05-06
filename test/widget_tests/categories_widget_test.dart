import 'package:delivery_app/models/firebase_recepcionist.dart';
import 'package:delivery_app/models/market.dart';
import 'package:delivery_app/pages/app.dart';
import 'package:delivery_app/pages/categories.dart';
import 'package:delivery_app/pages/shelf.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  Market market;
  FirebaseRecepcionist recepcionist;
  List<Map<String, dynamic>> categories = [
    {
      'name': 'Comidas',
      'products': [
        {'name': 'Empanadas', 'price': 10},
        {'name': 'Pizza', 'price': 100},
        {'name': 'Papas Fritas', 'price': 40}
      ]
    },
    {
      'name': 'Sports',
      'products': [
        {'name': 'Remera', 'price': 10},
        {'name': 'Zapatillas', 'price': 100},
        {'name': 'Pelota', 'price': 40}
      ]
    }
  ];

  setUp(() {
    recepcionist = FirebaseRecepcionist();
    market = recepcionist.addShelf(categories);
  });

  testWidgets("App shows a Category Tile for every cateory",
      (WidgetTester tester) async {
    await tester.pumpWidget(MarketHome(market));
    await tester.pumpAndSettle();
    expect(find.byType(CategoryTile), findsNWidgets(2));
  });

  testWidgets("Category Tile shows the name of the category",
      (WidgetTester tester) async {
    await tester.pumpWidget(MarketHome(market));
    await tester.pumpAndSettle();
    expect(find.text("Sports"), findsOneWidget);
    expect(find.text("Comidas"), findsOneWidget);
  });

  testWidgets("when a category is clicked redirects to a product detail",
      (WidgetTester tester) async {
    await tester.pumpWidget(MarketHome(market));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(CategoryTile).first);
    await tester.pumpAndSettle();
    expect(find.byType(ShelfPage), findsOneWidget);
  });
}
