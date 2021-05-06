import 'package:delivery_app/models/bag.dart';
import 'package:delivery_app/models/cart.dart';
import 'package:delivery_app/models/market.dart';
import 'package:delivery_app/pages/categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart.dart';

class MarketHome extends StatelessWidget {
  final Market market;
  final Cart cart = Cart();
  MarketHome(this.market);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Market>(
          create: (context) => this.market,
        ),
        ChangeNotifierProvider<Cart>(create: (context) => this.cart)
      ],
      child: MaterialApp(
        title: 'Product Market',
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey.shade900,
            title: Text(
              "Tienda",
              style: TextStyle(color: Color(0xffd9ad4a)),
            ),
          ),
          body: MarketCategories(),
          bottomNavigationBar: GoToBottomBar(GoToCart(), cart),
        ),
      ),
    );
  }
}

class GoToBottomBar extends StatelessWidget {
  final Widget goTo;
  final Cart cart;

  GoToBottomBar(this.goTo, this.cart);
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total: \$${cart.totalPrice}",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xffd9ad4a)),
            ),
            this.goTo,
          ],
        ),
        color: Colors.grey.shade900,
        padding: EdgeInsets.all(5),
      ),
    );
  }
}

class GoToCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Cart cart = Provider.of<Cart>(context);
    return MaterialButton(
        onPressed: () => {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CartDetail(cart)),
              ),
            },
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.shopping_cart, color: Color(0xffd9ad4a)),
          Text(
            "Ir al Carrito",
            style: TextStyle(color: Color(0xffd9ad4a)),
          ),
        ]));
  }
}

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    Bag bag = Provider.of<Bag>(context);
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.resolveWith((states) => Color(0xffd9ad4a))),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: bag.hasItems
                ? Text('${bag.product.name} añadidas al carrito!')
                : Text(
                    'Aumenta cantidad para añadir ${bag.product.name} al carrito!'),
            duration: Duration(seconds: 1),
          ),
        );

        cart.addBag(bag);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Añadir al carrito"),
          Icon(Icons.shopping_cart_outlined)
        ],
      ),
    );
  }
}
