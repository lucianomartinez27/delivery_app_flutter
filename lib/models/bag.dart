import 'package:flutter/foundation.dart';
import 'product.dart';

class Bag extends ChangeNotifier {
  int _total = 0;
  Product product;
  Bag.of(Product aProduct) {
    product = aProduct;
  }

  get total => _total;

  get hasItems => _total > 0;

  void addItem() {
    _total++;
    notifyListeners();
  }

  void removeItem() {
    if (_total == 0) {
      throw RangeError("The product quantity can't be less than zero.");
    }
    notifyListeners();
    _total--;
  }

  bool isOf(String aProductName) {
    return product.isNamed(aProductName);
  }
}
