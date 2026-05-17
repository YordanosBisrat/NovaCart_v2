import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product/product_bloc.dart';
import '../../bloc/product/product_event.dart';

class EditProductScreen extends StatefulWidget {
  final Map product;

  const EditProductScreen({super.key, required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController titleController;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.product['title']);
    priceController = TextEditingController(
      text: widget.product['price'].toString(),
    );
  }

  void update() {
    if (!_formKey.currentState!.validate()) return;

    context.read<ProductBloc>().add(
      UpdateProduct(widget.product['id'], {
        "title": titleController.text,
        "price": double.parse(priceController.text),
        "description": widget.product['description'],
        "image": widget.product['image'],
        "category": widget.product['category'],
      }),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Product")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Title"),
                validator: (value) => value!.isEmpty ? "Enter title" : null,
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Enter price" : null,
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: update,
                  child: const Text("Update Product"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
