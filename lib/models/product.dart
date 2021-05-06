import 'package:flutter/foundation.dart';

class Product {
  final String name;
  final int price;
  static const String INVALID_NAME_ERROR = "Name can not be empty";
  static const String INVALID_PRICE_ERROR = "Price can be less than zero.";

  Product({@required this.name, @required this.price}) {
    if (name.isEmpty) {
      throw InvalidNameError(INVALID_NAME_ERROR);
    } else if (price < 0) {
      throw ArgumentError(INVALID_PRICE_ERROR);
    }
  }

  // Is this the adequate way to add an imagen? I don't know.
  String get takePicture =>
      name.toLowerCase().splitMapJoin(RegExp(" "), onMatch: (m) => "_") +
      '.jpg';

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
