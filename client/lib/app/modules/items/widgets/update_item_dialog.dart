import 'package:client/app/data/models/category_model.dart';
import 'package:client/app/data/models/item_model.dart';
import 'package:client/app/data/models/item_update_model.dart';
import 'package:client/app/modules/items/controllers/item_controller.dart';
import 'package:client/app/modules/widgets/modal.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UpdateItemsDialog extends StatefulWidget {
  const UpdateItemsDialog(
      {super.key,
      required this.controller,
      required this.item,
      required this.itemGroupsCategory});

  final ItemController controller;
  final ItemModel item;
  final List<CategoryModel> itemGroupsCategory;

  @override
  State<UpdateItemsDialog> createState() => _UpdateItemsDialogState();
}

class _UpdateItemsDialogState extends State<UpdateItemsDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController categoryController;
  late TextEditingController stocksController;
  late TextEditingController groupController;
  late TextEditingController priceController;
  final List<String> itemGroups = ["dus", "stock"];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.item.itemsName);
    categoryController =
        TextEditingController(text: widget.item.categoryId.toString());
    stocksController =
        TextEditingController(text: widget.item.stocks.toString());
    groupController = TextEditingController(text: widget.item.itemsGroup);
    priceController = TextEditingController(text: widget.item.price.toString());
  }

  @override
  void dispose() {
    nameController.dispose();
    categoryController.dispose();
    stocksController.dispose();
    groupController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalComponents(
      icon: const Icon(Icons.edit),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildTextField(
              controller: nameController,
              label: 'Item Name',
              validator: (value) => value == null || value.isEmpty
                  ? 'Item Name is required'
                  : null,
            ),
            const SizedBox(height: 8.0),
            DropdownButtonFormField<int>(
              value: int.tryParse(categoryController.text),
              decoration: const InputDecoration(
                labelText: 'Category',
                labelStyle: TextStyle(color: Colors.grey),
              ),
              items: widget.itemGroupsCategory.map((category) {
                return DropdownMenuItem<int>(
                  value: category.id,
                  child: Text(category.categoryName),
                );
              }).toList(),
              onChanged: (value) {
                categoryController.text = value?.toString() ?? '';
              },
              validator: (value) {
                if (value == null) {
                  return 'Category is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 8.0),
            _buildTextField(
              controller: stocksController,
              label: 'Stocks',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Stocks are required';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid number for Stocks';
                }
                return null;
              },
            ),
            const SizedBox(height: 8.0),
            DropdownButtonFormField<String>(
              value:
                  groupController.text.isNotEmpty ? groupController.text : null,
              decoration: const InputDecoration(
                labelText: 'Item Group',
                labelStyle: TextStyle(color: Colors.grey),
              ),
              items: itemGroups.map((group) {
                return DropdownMenuItem<String>(
                  value: group,
                  child: Text(group),
                );
              }).toList(),
              onChanged: (value) {
                groupController.text = value ?? '';
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Item Group is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 8.0),
            _buildTextField(
              controller: priceController,
              label: 'Price',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Price is required';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number for Price';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      action: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                final updatedItem = ItemUpdateModel(
                  itemsName: nameController.text,
                  categoryId: int.tryParse(categoryController.text) ?? 0,
                  stocks: int.tryParse(stocksController.text) ?? 0,
                  itemsGroup: groupController.text,
                  price: double.tryParse(priceController.text) ?? 0.0,
                );
                final success = await widget.controller.updateItem(
                  id: widget.item.id,
                  itemData: updatedItem,
                );
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Item updated successfully')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to update item')),
                  );
                }
                if (context.mounted) {
                  context.pop();
                }
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}
