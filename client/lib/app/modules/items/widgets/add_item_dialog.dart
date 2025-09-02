import 'package:client/app/data/models/category_model.dart';
import 'package:client/app/data/models/item_update_model.dart';
import 'package:client/app/modules/items/controllers/item_controller.dart';
import 'package:client/app/modules/widgets/modal.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddItemsDialog extends StatelessWidget {
  const AddItemsDialog({
    super.key,
    required this.controller,
    required this.itemGroupsCategory,
  });

  final ItemController controller;
  final List<CategoryModel> itemGroupsCategory;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController categoryController = TextEditingController();
    final TextEditingController stocksController = TextEditingController();
    final TextEditingController groupController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final itemGroups = ["dus", "stock"];
    return ModalComponents(
      icon: Icon(Icons.add),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Item Name',
                labelStyle: TextStyle(color: Colors.grey),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Item Name is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 8.0),
            DropdownButtonFormField<int>(
              value: null,
              decoration: const InputDecoration(
                labelText: 'Category',
                labelStyle: TextStyle(color: Colors.grey),
              ),
              items: itemGroupsCategory.map((category) {
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
            TextFormField(
              controller: stocksController,
              decoration: const InputDecoration(
                labelText: 'Stocks',
                labelStyle: TextStyle(color: Colors.grey),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Stocks are required';
                }
                if (int.tryParse(value) == null) {
                  return 'Stocks must be a number';
                }
                return null;
              },
            ),
            const SizedBox(height: 8.0),
            DropdownButtonFormField<String>(
              value: null,
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
            TextFormField(
              controller: priceController,
              decoration: const InputDecoration(
                labelText: 'Price',
                labelStyle: TextStyle(color: Colors.grey),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Price is required';
                }
                if (double.tryParse(value) == null) {
                  return 'Price must be a valid number';
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
                final item = ItemUpdateModel(
                  itemsName: nameController.text,
                  categoryId: int.tryParse(categoryController.text) ?? 0,
                  stocks: int.tryParse(stocksController.text) ?? 0,
                  itemsGroup: groupController.text,
                  price: double.tryParse(priceController.text) ?? 0.0,
                );
                final success = await controller.createItem(item);
                if (context.mounted) {
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Item added successfully')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Failed to add item')),
                    );
                  }
                  context.pop();
                }
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
