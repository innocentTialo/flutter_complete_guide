import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

enum FilterOption { favorite, all }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOption selectedValue) => setState(
              () => {
                if (selectedValue == FilterOption.favorite)
                  _showOnlyFavorite = true
                else
                  _showOnlyFavorite = false
              },
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOption.favorite,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOption.all,
              ),
            ],
          ),
        ],
      ),
      body: ProductsGrid(_showOnlyFavorite),
    );
  }
}
