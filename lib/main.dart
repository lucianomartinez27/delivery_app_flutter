import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/pages/app.dart';
import 'package:delivery_app/services/firestore_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirestoreShelfRestocking firestoreRestocking =
      FirestoreShelfRestocking(FirebaseFirestore.instance);

  runApp(MarketHome(await firestoreRestocking.getStock()));
}
