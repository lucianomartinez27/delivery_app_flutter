import 'package:delivery_app/models/cart.dart';
import 'package:delivery_app/models/product.dart';
import 'package:delivery_app/models/product_shelf.dart';
import 'package:delivery_app/pages/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';

class ShelfPage extends StatelessWidget {
  final ProductShelf shelf;
  ShelfPage(this.shelf);
  @override
  Widget build(BuildContext context) {
    List<Product> products = shelf.allProducts;
    Cart cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: Text(
          "Tienda",
          style: TextStyle(color: Color(0xffd9ad4a)),
        ),
      ),
      body: Container(
        color: Colors.grey,
        child: Center(
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.white,
          child: Row(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                backgroundImage:
                    AssetImage('assets/images/${product.takePicture}'),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${product.name}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                      ),
                      Text('Descripción del producto'),
                      Align(
                          heightFactor: 2.5,
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            '\$${product.price}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      padding: EdgeInsets.all(10),
    );
  }
}
