import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products_provider.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _initialValues = {
    'id': '',
    'title': '',
    'description': '',
    'imageUrl': '',
    'price': '',
    'isFavorite': '',
  };
  var isEditMode = false;
  var _isInit = true;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_onImageUrlLooseFocus);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        final product =
            Provider.of<ProductsProvider>(context).findById(productId);

        _initialValues = {
          'id': product.id,
          'title': product.title,
          'description': product.description,
          'price': product.price.toString(),
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite.toString(),
        };
        _imageUrlController.text = _initialValues['imageUrl'];
      }

      isEditMode = _initialValues['id'] != '';
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _onImageUrlLooseFocus() {
    if (!_imageUrlController.text.startsWith('http') ||
        !_imageUrlController.text.startsWith('https')) {
      return;
    }
    setState(() {});
  }

  void _submitForm() {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    _form.currentState.save();
    var _isFormValid = _form.currentState.validate();
    if (!_isFormValid) {
      return;
    }

    var productToSubmit = Product(
      id: _initialValues['id'] != ''
          ? _initialValues['id']
          : DateTime.now().toString(),
      title: _initialValues['title'],
      description: _initialValues['description'],
      price: double.parse(_initialValues['price']),
      imageUrl: _initialValues['imageUrl'],
      isFavorite: bool.fromEnvironment(_initialValues['isFavorite']),
    );

    if (isEditMode) {
      productsProvider.updateProduct(productToSubmit);
    } else {
      productsProvider.addProduct(productToSubmit);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isEditMode ? Text('Edit Product') : Text('Add Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _submitForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                initialValue: _initialValues['title'],
                onSaved: (value) => _initialValues['title'] = value,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'The product title is required!';
                  }
                  return null;
                },
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_priceFocusNode),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                initialValue: _initialValues['price'],
                onSaved: (value) => _initialValues['price'] = value,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'The product price is required!';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Enter a valid price!';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Price should be greater than 0';
                  }
                  return null;
                },
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_descriptionFocusNode),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                initialValue: _initialValues['description'],
                onSaved: (value) => _initialValues['description'] = value,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'The description is required!';
                  }
                  if (value.length <= 10) {
                    return 'The description must have at least 10 caracters';
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(
                      top: 10,
                      right: 5,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                            ),
                            fit: BoxFit.cover,
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onSaved: (value) => _initialValues['imageUrl'] = value,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter an image url';
                        }
                        if (!value.startsWith('http') ||
                            !value.startsWith('https')) {
                          return 'Please enter a valid url';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) => _submitForm(),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
