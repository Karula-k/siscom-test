import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/item_controller.dart';
import '../widgets/item_card.dart';
import '../widgets/item_form_dialog.dart';

class ItemsView extends GetView<ItemController> {
  const ItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.refreshItems(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.items.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.error.value.isNotEmpty && controller.items.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'Error loading items',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  controller.error.value,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.refreshItems(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (controller.items.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.inventory_2_outlined,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No items found',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Add your first item to get started',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshItems,
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.items.length +
                (controller.hasMoreData.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == controller.items.length) {
                // Load more indicator
                if (controller.isLoadingMore.value) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  // Trigger load more
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    controller.loadMoreItems();
                  });
                  return const SizedBox.shrink();
                }
              }

              final item = controller.items[index];
              return ItemCard(
                item: item,
                onTap: () => _showItemDetails(context, item),
                onEdit: () => _showEditDialog(context, item),
                onDelete: () => _showDeleteDialog(context, item),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showItemDetails(BuildContext context, item) {
    Get.dialog(
      AlertDialog(
        title: Text(item.itemsName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${item.id}'),
            Text('Category ID: ${item.categoryId}'),
            Text('Stock: ${item.stocks}'),
            Text('Group: ${item.itemsGroup}'),
            Text('Price: \$${item.price.toStringAsFixed(2)}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    Get.dialog(
      ItemFormDialog(
        onSubmit: (data) async {
          final success = await controller.createItem(data);
          if (success) {
            Get.back();
          }
        },
      ),
    );
  }

  void _showEditDialog(BuildContext context, item) {
    Get.dialog(
      ItemFormDialog(
        item: item,
        onSubmit: (data) async {
          final success = await controller.updateItem(item.id, data);
          if (success) {
            Get.back();
          }
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, item) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Item'),
        content: Text('Are you sure you want to delete "${item.itemsName}"?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Get.back();
              await controller.deleteItem(item.id);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
