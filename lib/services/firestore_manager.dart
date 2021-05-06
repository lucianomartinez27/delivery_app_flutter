import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/models/firebase_recepcionist.dart';
import 'package:delivery_app/models/market.dart';

class FirestoreShelfRestocking {
  FirebaseFirestore instance;
  FirestoreShelfRestocking(this.instance);
  FirebaseRecepcionist recepcionist = FirebaseRecepcionist();

  Future<QuerySnapshot> get categoriesCollection => instance
      .collection('categories')
      .get()
      .then((collectionData) => collectionData);

  Future<List<Map<String, dynamic>>> categories() {
    return categoriesCollection.then(
        (value) => value.docs.map((categories) => categories.data()).toList());
  }

  Future<Market> getStock() async {
    return recepcionist.addShelf(await categories());
  }
}
