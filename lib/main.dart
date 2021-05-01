import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/pages/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
