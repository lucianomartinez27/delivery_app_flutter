import 'package:delivery_app/models/bag.dart';
import 'package:delivery_app/models/cart.dart';
import 'package:delivery_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';

class ProductDetail extends StatelessWidget {
  final Product product;
  ProductDetail(this.product);
  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of<Cart>(context);
    return ChangeNotifierProvider(
      create: (context) => Bag.of(product),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade900,
          title: Text(
            "Tienda",
            style: TextStyle(color: Color(0xffd9ad4a)),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                height: 200,
                child: Card(
                  child: Image.asset('assets/images/${product.takePicture}'),
                ),
              ),
              Text(product.name, style: TextStyle(fontSize: 32)),
              Card(
                color: Colors.amber,
                child: Text(
                  "Descripción del producto",
                  style: TextStyle(fontSize: 22),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.all(16),
                child: ChooseQuantity(),
              ),
            ],
          ),
        ),
        floatingActionButton: AddToCartButton(cart: cart),
        bottomNavigationBar: GoToBottomBar(GoToCart(), cart),
      ),
    );
  }
}

class ChooseQuantity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Bag bag = Provider.of<Bag>(context);

    return Container(
      child: Align(
        alignment: FractionalOffset.bottomLeft,
        child: Column(
          children: [
            Text("Candidad:"),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        try {
                          bag.removeItem();
                        } on RangeError {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("No puedes bajar de cero."),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        }
                      }),
                  Center(
                    child: Text("${bag.total}"),
                  ),
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        bag.addItem();
                      })
                ]),
          ],
        ),
      ),
    );
  }
}
