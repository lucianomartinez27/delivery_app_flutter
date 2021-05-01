import 'package:delivery_app/models/cart.dart';
import 'package:delivery_app/models/product.dart';
import 'package:flutter/material.dart';

import 'app.dart';

class CartDetail extends StatelessWidget {
  final Cart cart;
  CartDetail(this.cart);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: cart.hasProducts()
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: cart.uniqueProducts
                    .map<Widget>((product) =>
                        ProductOnCartDetail(cart: cart, product: product))
                    .toList())
            : EmptyCart(),
      ),
      bottomNavigationBar: GoToBottomBar(GoToCart(), cart),
    );
  }
}

class ProductOnCartDetail extends StatelessWidget {
  const ProductOnCartDetail({
    Key key,
    @required this.cart,
    @required this.product,
  }) : super(key: key);

  final Cart cart;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Precio unitario: \$${product.price}"),
            Text("Precio total: \$${cart.totalPriceOf(product)}")
          ],
        ),
        tileColor: Colors.lightBlueAccent,
        title: Text("${product.name}", style: TextStyle(fontSize: 23)),
        subtitle: Text("Cantidad: ${cart.totalOf(product)}"),
      ),
    );
  }
}

class EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Flexible(
          child: Text(
            "Ups... todavia no has agreado nada al carrito.",
            style: TextStyle(
              color: Colors.black,
              decorationColor: Colors.red,
              decorationStyle: TextDecorationStyle.wavy,
              fontSize: 18,
            ),
          ),
        ),
        Icon(Icons.shopping_cart_outlined)
      ]),
    ));
  }
}
