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
          bottomSheet: GoToCartBottomBar(cart),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<ProductShelf>(context).allProducts;
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: products
                .map<Widget>(
                  (product) => GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => ProductDetail(product)),
                    ),
                    child: Container(
                      child: ListTile(
                        leading: Icon(Icons.fastfood, size: 50),
                        title:
                            Text('${product.name} - Price: ${product.price}'),
                        subtitle: Text('Oferta'),
                      ),
                      color: Colors.greenAccent,
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

class GoToCartBottomBar extends StatelessWidget {
  final Cart cart;
  GoToCartBottomBar(this.cart);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MaterialButton(
                onPressed: () => {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => CartDetail(cart)),
                      ),
                    },
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.store),
                  Text("Ir al Carrito"),
                ]))
          ],
        ),
        color: Colors.blue,
        padding: EdgeInsets.all(20),
      ),
    );
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
          children: [Text(product.name)],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          cart.addProduct(product);
        },
        child: Icon(Icons.add),
      ),
      bottomSheet: GoToCartBottomBar(cart),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: cart.uniqueProducts
              .map<Widget>((product) =>
                  Text("${product.name} - ${cart.totalOf(product)}"))
              .toList(),
        ),
      ),
    );
  }
}
