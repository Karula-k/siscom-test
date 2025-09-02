import 'package:client/app/data/models/item_model.dart';
import 'package:client/app/modules/items/controllers/item_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeleteItemDialog extends StatelessWidget {
  const DeleteItemDialog({
    super.key,
    required this.controller,
    required this.item,
  });

  final ItemController controller;
  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Item'),
      content: Text('Are you sure you want to delete "${item.itemsName}"?'),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () async {
            context.pop();
            final result = await controller.deleteItem(item.id);
            if (result) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Item deleted successfully')),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to delete item')),
              );
            }
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
