import 'package:delivery_app/models/bag.dart';
import 'package:delivery_app/models/cart.dart';
import 'package:delivery_app/models/product_shelf.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart.dart';
import 'home.dart';

class MyApp extends StatelessWidget {
  final Stream<ProductShelf> productShelf;
  final Cart cart = Cart();
  MyApp(this.productShelf);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<ProductShelf>(
            create: (context) => this.productShelf,
            initialData: ProductShelf()),
        ChangeNotifierProvider<Cart>(create: (context) => this.cart)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Mi Tienda"),
          ),
          body: HomePage(),
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
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            this.goTo,
          ],
        ),
        color: Colors.blue,
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
          Icon(Icons.shopping_cart),
          Text("Ir al Carrito"),
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
