// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:async';
import 'package:delivery_app/models/product_shelf.dart';
import 'package:delivery_app/models/services/firestore_manager.dart';
import 'package:delivery_app/pages/app.dart';
import 'package:delivery_app/pages/cart.dart';
import 'package:delivery_app/pages/home.dart';
import 'package:delivery_app/pages/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

ProductStand stand;
Stream<ProductShelf> productShelf;
void main() {
  Future _clickOnProduct(WidgetTester tester) async {
    await tester.pumpWidget(MyApp(productShelf));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(GestureDetector).first);
    await tester.pumpAndSettle();
  }

  setUp(() {
    stand = ProductStand();
    stand.newProductList([
      {'name': 'Ice Cream', 'price': 10},
      {'name': 'Snacks', 'price': 5},
    ]);
    productShelf = stand.onNewProductList;
  });

  testWidgets('Products appear on Home Screen', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(productShelf));
    await tester.pumpAndSettle();
    expect(find.byType(ProductTile), findsNWidgets(2));
  });

  testWidgets('When a product is clicked it redirects to ProductDetail page',
      (WidgetTester tester) async {
    await _clickOnProduct(tester);
    expect(find.byType(ProductDetail), findsOneWidget);
  });

  testWidgets('A Product Detail shows the correct product',
      (WidgetTester tester) async {
    await _clickOnProduct(tester);
    expect(find.text("Ice Cream"), findsOneWidget);
  });
  testWidgets('There is a button that redirects to CartDetail on Home',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(productShelf));
    await tester.pumpAndSettle();
    expect(find.byType(MaterialButton), findsOneWidget);
    await tester.tap(find.byType(MaterialButton));
    await tester.pumpAndSettle();
    expect(find.byType(CartDetail), findsOneWidget);
  });

  testWidgets('There is a button that redirects to CartDetail on ProductDetail',
      (WidgetTester tester) async {
    await _clickOnProduct(tester);
    expect(find.byType(MaterialButton), findsOneWidget);
    await tester.tap(find.byType(MaterialButton));
    await tester.pumpAndSettle();
    expect(find.byType(CartDetail), findsOneWidget);
  });

  testWidgets('Product Detail shows a button to add product to cart',
      (WidgetTester tester) async {
    await _clickOnProduct(tester);
    expect(find.byType(AddToCartButton), findsOneWidget);
  });

  testWidgets('A cart has no products on a recently opened App',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(productShelf));
    await tester.pumpAndSettle();

    expect(
        (find.byType(MyApp).evaluate().single.widget as MyApp)
            .cart
            .hasProducts(),
        isFalse);
  });

  testWidgets('A product can be added to the cart from ProductDetail page',
      (WidgetTester tester) async {
    await _clickOnProduct(tester);
    await tester.tap(find.byType(AddToCartButton));
    await tester.tap(find.byType(MaterialButton));
    await tester.pumpAndSettle();

    expect(
        (find.byType(CartDetail).evaluate().single.widget as CartDetail)
            .cart
            .hasProducts(),
        isTrue);
  });

  testWidgets('A cart shows the added product', (WidgetTester tester) async {
    await _clickOnProduct(tester);
    await tester.tap(find.byType(AddToCartButton));
    await tester.tap(find.byType(AddToCartButton));
    await tester.tap(find.byType(MaterialButton));
    await tester.pumpAndSettle();

    expect(find.byType(ProductOnCartDetail), findsOneWidget);
  });

  testWidgets('Cart with no products shows a EmptyCart widget',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(productShelf));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(MaterialButton));
    await tester.pumpAndSettle();
    expect(find.byType(EmptyCart), findsOneWidget);
  });

  testWidgets('ProductDetail has ChooseQuantity widget',
      (WidgetTester tester) async {
    await _clickOnProduct(tester);
    expect(find.byType(ChooseQuantity), findsOneWidget);
  });

  testWidgets('It is possible to select the quantity of a product',
      (WidgetTester tester) async {
    await _clickOnProduct(tester);
    await tester.pumpAndSettle();

    expect(find.text("0"), findsOneWidget);
    // searching for the add icon button
    await tester.tap(find.byType(IconButton).at(1));
    await tester.pumpAndSettle();
    expect(find.text("1"), findsOneWidget);
    // searching for the remove icon button
    await tester.tap(find.byType(IconButton).at(0));
    await tester.pumpAndSettle();
    expect(find.text("0"), findsOneWidget);
  });
}
