import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/models/cart.dart';
import 'package:delivery_app/models/product.dart';
import 'package:delivery_app/models/product_shelf.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/services/firestore_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirestoreProductManager firestoreProductManager =
      FirestoreProductManager(FirebaseFirestore.instance);
  ProductStand stand = ProductStand();
  firestoreProductManager.onNewProductsDo((newProduct) {
    stand.newProductList(newProduct);
  });
  runApp(MyApp(stand.onNewProductList));
}

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

class ProductDetail extends StatelessWidget {
  final Product product;
  ProductDetail(this.product);
  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(product.name, style: TextStyle(fontSize: 32)),
            Card(
              color: Colors.amber,
              child: Text(
                "Descripción del producto",
                style: TextStyle(fontSize: 22),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: AddToCartButton(product: product, cart: cart),
      bottomNavigationBar: GoToBottomBar(GoToCart(), cart),
    );
  }
}

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    Key key,
    @required this.product,
    @required this.cart,
  }) : super(key: key);

  final Product product;
  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${product.name} añadidas al carrito!'),
            duration: Duration(seconds: 1),
          ),
        );

        cart.addProduct(product);
      },
      child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [Text("Añadir al carrito"), Icon(Icons.add)]),
    );
  }
}

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
