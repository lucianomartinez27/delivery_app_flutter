import 'package:flutter/foundation.dart';

class Product {
  final String name;
  final int price;

  Product({@required this.name, @required this.price}) {
    if (name.isEmpty) {
      throw InvalidNameError("Name can not be empty");
    }
  }

  bool isNamed(String s) {
    return true;
  }
}

class InvalidNameError implements Exception {
  String msg;
  InvalidNameError(this.msg);

  @override
  String toString() {
    return "InvalidNameError: $msg";
  }
}
