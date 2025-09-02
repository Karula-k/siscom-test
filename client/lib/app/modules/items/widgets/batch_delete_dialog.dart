import 'package:flutter/material.dart';
import '../controllers/item_controller.dart';
import 'package:go_router/go_router.dart';

class BatchDeleteDialog extends StatelessWidget {
  final ItemController controller;

  const BatchDeleteDialog({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Items'),
      content: const Text('Are you sure you want to delete these items?'),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () async {
            context.pop();
            context.pop();
            final result = await controller.deleteSelectedItems();
            if (result) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Items deleted successfully')),
              );
            } else {
              
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to delete items')),
              );
            }
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
