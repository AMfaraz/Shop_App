import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "./edit_product_screen";

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _descriptionFocusNode = FocusNode();
  final _imageURLController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();

  var _editedProduct = Product(
    id: null,
    title: "",
    description: "",
    imgurl: "",
    price: 0,
  );

  final _form = GlobalKey<FormState>();

  @override
  void dispose() {
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageURLController.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);

    super.dispose();
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);

    super.initState();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  var _isLoading = false;

  Future<void> _saveForm() async {
    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }

    _form.currentState?.save();

    setState(() {
      _isLoading = true;
    });

    if (_editedProduct.id != null) {
      await Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id!, _editedProduct);

      setState(() {
        _isLoading = false;
      });

      Navigator.pop(context);
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (error) {
        // TODO
        await showDialog<Null>(
            context: context,
            builder: (ctx) =>
                AlertDialog(
                  title: const Text("An error occured"),
                  content: Text(error.toString()),
                  actions: [
                    TextButton(onPressed: () {
                      Navigator.of(context).pop();
                    }, child: const Text("okay"))
                  ],
                ));
      }
      // .catchError((error) {
      // return showDialog<Null>(
      //     context: context,
      //     builder: (ctx) => AlertDialog(
      //           title: Text("An error occured"),
      //           content: Text(error.toString()),
      //       actions: [
      //         TextButton(onPressed: (){
      //           Navigator.of(context).pop();
      //         }, child: Text("okay"))
      //       ],
      //         ));
      // }).then((_) {
      finally {
        setState(() {
          _isLoading = false;
        });
        Navigator.pop(context);
        // });
        // Navigator.pop(context);
      }
    }
  }

  var _isInit = true;

  var _initValues = {
    "title": "",
    "description": "",
    "price": "",
    "imgUrl": "",
  };

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = (ModalRoute.of(context)?.settings.arguments) as String?;

      if (productId != null) {
        final product =
            Provider.of<Products>(context, listen: false).findById(productId);
        _editedProduct = product;

        _initValues = {
          "title": _editedProduct.title!,
          "description": _editedProduct.description!,
          "price": _editedProduct.price!.toString(),
          "imgUrl": "",
        };
        _imageURLController.text = _editedProduct.imgurl!;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Product"),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                _saveForm();
              },
              icon: const Icon(Icons.save)),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues["title"],
                      decoration: const InputDecoration(
                        labelText: "Title",
                      ),
                      textInputAction: TextInputAction.next,
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          description: _editedProduct.description,
                          title: value,
                          imgurl: _editedProduct.imgurl,
                          price: _editedProduct.price,
                          isFavourite: _editedProduct.isFavourite,
                        );
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please provide a value";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues["price"],
                      decoration: const InputDecoration(
                        labelText: "Price",
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            description: _editedProduct.description,
                            title: _editedProduct.title,
                            imgurl: _editedProduct.imgurl,
                            price: double.parse(value!),
                            isFavourite: _editedProduct.isFavourite);
                      },
                      validator: (value) {
                        if (double.tryParse(value!) == null) {
                          return "Please a valid price";
                        }
                        if (double.tryParse(value)! <= 0) {
                          return "Enter a number greater than 0";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues["description"],
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: "Description",
                      ),
                      keyboardType: TextInputType.multiline,
                      // textInputAction: TextInputAction.next,
                      focusNode: _descriptionFocusNode,
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            description: value,
                            title: _editedProduct.title,
                            imgurl: _editedProduct.imgurl,
                            price: _editedProduct.price,
                            isFavourite: _editedProduct.isFavourite);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please provide a value";
                        }
                        if (value.length < 10) {
                          return "Should be atlease 10 characters long";
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
                          margin: const EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: _imageURLController.text.isEmpty
                              ? const Text("Enter the URL")
                              : FittedBox(
                                  child:
                                      Image.network(_imageURLController.text),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            // initialValue: _initValues["imgUrl"],
                            decoration: const InputDecoration(
                              labelText: "Image Url",
                            ),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageURLController,
                            focusNode: _imageUrlFocusNode,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            onSaved: (value) {
                              _editedProduct = Product(
                                  id: _editedProduct.id,
                                  description: _editedProduct.description,
                                  title: _editedProduct.title,
                                  imgurl: value,
                                  price: _editedProduct.price,
                                  isFavourite: _editedProduct.isFavourite);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter image url";
                              }
                              if (!value.startsWith("http") &&
                                  !value.startsWith("https")) {
                                return "Enter a valid url";
                              }
                              return null;
                            },
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
