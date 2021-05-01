import 'package:delivery_app/models/cart.dart';
import 'package:delivery_app/models/product.dart';
import 'package:delivery_app/models/product_shelf.dart';
import 'package:delivery_app/pages/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<ProductShelf>(context).allProducts;
    Cart cart = Provider.of<Cart>(context);

    return Scaffold(
      body: Center(
        child: ListView(
            children: products
                .map<Widget>(
                  (product) => GestureDetector(
                      onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => ProductDetail(product)),
                          ),
                      child: ProductTile(product)),
                )
                .toList()),
      ),
      bottomNavigationBar: GoToBottomBar(GoToCart(), cart),
    );
  }
}

class ProductTile extends StatelessWidget {
  final Product product;
  ProductTile(this.product);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Icon(Icons.fastfood, size: 50),
        title: Text('${product.name} - Precio: \$${product.price}'),
        subtitle: Text('Descripción del producto'),
      ),
      color: Colors.lightBlueAccent,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
    );
  }
}
