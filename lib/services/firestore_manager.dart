import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/models/firebase_recepcionist.dart';
import 'package:delivery_app/models/product_shelf.dart';

class FirestoreProductManager {
  FirebaseFirestore instance;
  FirestoreProductManager(this.instance);
  Stream<QuerySnapshot> get productsCollection =>
      instance.collection('products').snapshots();

  Stream<List<Map<String, dynamic>>> products() {
    return productsCollection.map(
        (event) => (event.docs.map((products) => products.data()).toList()));
  }

  void onNewProductsDo(Function withProductListDo) {
    products().listen((productList) {
      withProductListDo(productList);
    });
  }
}

class ProductStand {
  StreamController<ProductShelf> _controller = StreamController<ProductShelf>();
  FirebaseRecepcionist recepcionist = FirebaseRecepcionist();

  Stream<ProductShelf> get onNewProductList => _controller.stream;

  void newProductList(List<Map<String, dynamic>> productList) {
    _controller.add(recepcionist.loadProducts(productList));
  }
}
