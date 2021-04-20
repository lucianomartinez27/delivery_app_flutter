import 'package:delivery_app/models/product.dart';
import 'package:delivery_app/models/product_shelf.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  ProductShelf productShelf = ProductShelf();
  productShelf.addProduct(Product(name: "Ice Cram", price: 10));
  productShelf.addProduct(Product(name: "Snacks", price: 10));

  runApp(MyApp(productShelf));
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
      home: Scaffold(
        appBar: AppBar(),
        body: ChangeNotifierProvider(
            create: (context) => this.productShelf, child: HomePage()),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var products = Provider.of<ProductShelf>(context).allProducts;

    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: products
                .map<Widget>(
                  (product) => GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProductDetail()),
                    ),
                    child: Container(
                      child: Text('${product.name} - Price: ${product.price}'),
                      color: Colors.red,
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(10),
                    ),
                  ),
                )
                .toList()),
      ),
    );
  }
}

class ProductDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
