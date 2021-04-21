// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:delivery_app/models/product.dart';
import 'package:delivery_app/models/product_shelf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:delivery_app/main.dart';

ProductShelf productShelf;

void main() {
  setUp(() {
    productShelf = ProductShelf();
    productShelf.addProduct(Product(name: "Ice Cream", price: 10));
  });
  testWidgets('Products appear on Home Screen', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(productShelf));
    expect(find.text("Ice Cream - Price: 10"), findsOneWidget);
    productShelf.addProduct(Product(name: "Snacks", price: 5));
    await tester.pump();
    expect(find.text("Snacks - Price: 5"), findsOneWidget);
  });

  testWidgets('When a product is clicked it redirects to ProductDetail page',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(productShelf));

    await tester.tap(find.byType(GestureDetector).first);
    await tester.pumpAndSettle();
    expect(find.byType(ProductDetail), findsOneWidget);
  });

  testWidgets('There is a button that redirects to CartDetail',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(productShelf));

    expect(find.byType(MaterialButton), findsOneWidget);
    await tester.tap(find.byType(MaterialButton));
    await tester.pumpAndSettle();
    expect(find.byType(CartDetail), findsOneWidget);
  });
}
