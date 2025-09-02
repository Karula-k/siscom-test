import 'package:flutter/material.dart';
import '../../../data/models/item_model.dart';

class ItemFormDialog extends StatefulWidget {
  final ItemModel? item;
  final Function(Map<String, dynamic>) onSubmit;

  const ItemFormDialog({
    super.key,
    this.item,
    required this.onSubmit,
  });

  @override
  State<ItemFormDialog> createState() => _ItemFormDialogState();
}

class _ItemFormDialogState extends State<ItemFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _categoryIdController;
  late TextEditingController _stocksController;
  late TextEditingController _groupController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item?.itemsName ?? '');
    _categoryIdController = TextEditingController(
      text: widget.item?.categoryId.toString() ?? '',
    );
    _stocksController = TextEditingController(
      text: widget.item?.stocks.toString() ?? '',
    );
    _groupController =
        TextEditingController(text: widget.item?.itemsGroup ?? '');
    _priceController = TextEditingController(
      text: widget.item?.price.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryIdController.dispose();
    _stocksController.dispose();
    _groupController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.item == null ? 'Add Item' : 'Edit Item'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Item Name',
                  hintText: 'Enter item name',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter item name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _categoryIdController,
                decoration: const InputDecoration(
                  labelText: 'Category ID',
                  hintText: 'Enter category ID',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter category ID';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _stocksController,
                decoration: const InputDecoration(
                  labelText: 'Stock Quantity',
                  hintText: 'Enter stock quantity',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter stock quantity';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _groupController,
                decoration: const InputDecoration(
                  labelText: 'Item Group',
                  hintText: 'Enter item group',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter item group';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  hintText: 'Enter price',
                  prefixText: '\$ ',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          child: Text(widget.item == null ? 'Add' : 'Update'),
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final data = {
        'itemsName': _nameController.text.trim(),
        'categoryId': int.parse(_categoryIdController.text.trim()),
        'stocks': int.parse(_stocksController.text.trim()),
        'itemsGroup': _groupController.text.trim(),
        'price': double.parse(_priceController.text.trim()),
      };

      widget.onSubmit(data);
    }
  }
}
