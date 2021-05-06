import 'package:delivery_app/models/market.dart';
import 'package:delivery_app/models/product_shelf.dart';
import 'package:delivery_app/pages/shelf.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class MarketCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<ProductShelf> shelfs = Provider.of<Market>(context).shelfs;

    return Container(
      color: Colors.black26,
      child: Center(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: shelfs.length,
          itemBuilder: (context, index) => CategoryTile(shelf: shelfs[index]),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    Key key,
    @required this.shelf,
  }) : super(key: key);

  final ProductShelf shelf;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Stack(fit: StackFit.passthrough, children: [
        GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ShelfPage(shelf)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image(
              height: 100,
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.6),
              colorBlendMode: BlendMode.darken,
              image: AssetImage(
                  'assets/images/${shelf.category.toLowerCase()}.jpg'),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              shelf.category,
              style: TextStyle(
                color: Colors.grey.shade100,
                fontSize: 24,
              ),
            ),
          ),
        )
      ]),
    );
  }
}
