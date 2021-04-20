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
import 'package:provider/provider.dart';

void main() {
  ProductShelf productShelf = ProductShelf();
  productShelf.addProduct(Product(name: "Ice Cream", price: 10));

  testWidgets('Products appear on Home Screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<ProductShelf>(
        create: (context) => productShelf,
        child: MaterialApp(home: HomePage()),
      ),
    );
    expect(find.text("Ice Cream - Price: 10"), findsOneWidget);
    productShelf.addProduct(Product(name: "Snacks", price: 5));
    await tester.pump();
    expect(find.text("Snacks - Price: 5"), findsOneWidget);
  });

  testWidgets('When a product is clicked it redirects to ProductDetail page',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<ProductShelf>(
        create: (context) => productShelf,
        child: MaterialApp(home: HomePage()),
      ),
    );

    await tester.tap(find.byType(GestureDetector));
    await tester.pumpAndSettle();
    expect(find.byType(ProductDetail), findsOneWidget);
  });
}
