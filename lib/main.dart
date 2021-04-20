import 'package:delivery_app/models/product.dart';
import 'package:delivery_app/models/product_shelf.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  ProductShelf productShelf = ProductShelf();
  productShelf.addProduct(Product(name: "Helado", price: 10));
  productShelf.addProduct(Product(name: "Snacks", price: 10));

  runApp(MyApp(productShelf));
}

class MyApp extends StatelessWidget {
  final ProductShelf productShelf;
  MyApp(this.productShelf);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Mi Tienda"),
        ),
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
                      child: ListTile(
                        leading: Icon(Icons.fastfood, size: 50),
                        title: Text('${product.name} Price: ${product.price}'),
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
      bottomSheet: BottomAppBar(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                  onPressed: () => {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => CartDetail()),
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
      ),
    );
  }
}

class ProductDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("DETALLE DE PRODUCTO")],
        ),
      ),
    );
  }
}

class CartDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("CARRITO")],
        ),
      ),
    );
  }
}
