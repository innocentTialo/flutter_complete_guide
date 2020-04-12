import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static final routeName = '/product-details';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final product = Provider.of<ProductsProvider>(
      context,
      listen: false,
    ).findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Container(),
    );
  }
}
