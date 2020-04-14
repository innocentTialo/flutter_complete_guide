import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';
import './cart_screen.dart';
import '../widgets/app_drawer.dart';

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
          Consumer<CartProvider>(
            builder: (_, cartProvider, child) => Badge(
              child: child,
              value: cartProvider.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              },
            ),
          ),
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
      drawer: AppDrawer(),
    );
  }
}
