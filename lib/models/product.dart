import 'package:flutter/foundation.dart';

class Product {
  final String name;
  final int price;

  Product({@required this.name, @required this.price}) {
    if (name.isEmpty) {
      throw InvalidNameError("Name can not be empty");
    } else if (price < 0) {
      throw ArgumentError("Price can be less than zero.");
    }
  }

  bool isNamed(String potentialName) {
    return name == potentialName;
  }

  bool isPriced(int potentialPrice) {
    return price == potentialPrice;
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
