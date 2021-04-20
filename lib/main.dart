import 'package:delivery_app/models/product_shelf.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp(ProductShelf()));
}

class MyApp extends StatelessWidget {
  final ProductShelf productShelf;
  MyApp(this.productShelf);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
          create: (context) => this.productShelf, child: HomePage()),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var products = Provider.of<ProductShelf>(context).allProducts;
    return Container(
      child: Scaffold(
        body: Center(
          child: Column(
              children: products
                  .map<Widget>((product) =>
                      Text('${product.name} - Price: ${product.price}'))
                  .toList()),
        ),
      ),
    );
  }
}
