import 'package:delivery_app/models/product_shelf.dart';
import 'package:flutter/cupertino.dart';

class Market extends ChangeNotifier {
  static const String DUPLICATED_SHELF =
      'Shelf with that category already exists';

  List<ProductShelf> shelfs = [];

  bool hasShelfOf(String shelfCategoryToCompare) => shelfs.any(
      (productShelf) => productShelf.isCategorizedAs(shelfCategoryToCompare));

  void addShelf(ProductShelf shelfToAdd) {
    if (hasShelfOf(shelfToAdd.category)) {
      throw Exception(DUPLICATED_SHELF);
    }
    notifyListeners();

    shelfs.add(shelfToAdd);
  }
}
