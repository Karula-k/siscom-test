import 'package:client/app/modules/items/widgets/add_item_dialog.dart';
import 'package:client/app/modules/items/widgets/batch_delete_dialog.dart';
import 'package:client/app/modules/items/widgets/delete_item_dialog.dart';
import 'package:client/app/modules/items/widgets/details_iten_widget.dart';
import 'package:client/app/modules/items/widgets/update_item_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/item_controller.dart';
import '../widgets/item_card.dart';

class ItemsPage extends GetView<ItemController> {
  const ItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: controller.isSelectionMode.value
                ? Text(
                    '${controller.selectedItemIds.length} of ${controller.items.length} selected')
                : const Text('Items'),
            backgroundColor: controller.isSelectionMode.value
                ? Theme.of(context).colorScheme.secondaryContainer
                : null,
            actions: [
              controller.isSelectionMode.value
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          color: Colors.red,
                          icon: const Icon(Icons.select_all),
                          onPressed: () => controller.selectAllItems(),
                          tooltip: 'Select All',
                        ),
                        IconButton(
                          color: Colors.red,
                          icon: const Icon(Icons.clear),
                          onPressed: () => controller.clearSelection(),
                          tooltip: 'Clear Selection',
                        ),
                        IconButton(
                          color: Colors.red,
                          icon: const Icon(Icons.close),
                          onPressed: () => controller.toggleSelectionMode(),
                          tooltip: 'Exit Selection Mode',
                        ),
                      ],
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          color: Colors.red,
                          icon: const Icon(Icons.checklist),
                          onPressed: () => controller.toggleSelectionMode(),
                          tooltip: 'Select Items',
                        ),
                        IconButton(
                          color: Colors.red,
                          icon: const Icon(Icons.refresh),
                          onPressed: () => controller.refreshItems(),
                        ),
                      ],
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
                    FilledButton(
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
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        controller.loadMoreItems();
                      });
                      return const SizedBox.shrink();
                    }
                  }

                  final item = controller.items[index];
                  return Obx(() => controller.isSelectionMode.value
                      ? Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: CheckboxListTile(
                            value: controller.isItemSelected(item.id),
                            onChanged: (bool? value) {
                              controller.toggleItemSelection(item.id);
                            },
                            title: Text(item.itemsName),
                            subtitle: Text(
                                '${item.itemsGroup} - Rp ${NumberFormat('#,##0', 'id_ID').format(item.price)}'),
                            secondary: CircleAvatar(
                              child: Text(
                                  item.itemsName.substring(0, 1).toUpperCase()),
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        )
                      : ItemCard(
                          item: item,
                          onTap: () => showModalBottomSheet(
                                context: context,
                                builder: (context) => DetailsWidget(item: item),
                              ),
                          onEdit: () => showDialog(
                                context: context,
                                builder: (context) => UpdateItemsDialog(
                                  controller: controller,
                                  item: item,
                                  itemGroupsCategory: controller.categories,
                                ),
                              ),
                          onDelete: () => showDialog(
                                context: context,
                                builder: (context) => DeleteItemDialog(
                                    controller: controller, item: item),
                              )));
                },
              ),
            );
          }),
          floatingActionButton: Obx(() => controller.selectedItemIds.isNotEmpty
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton(
                      heroTag: "delete_selected",
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) =>
                            BatchDeleteDialog(controller: controller),
                      ),
                      backgroundColor: Colors.red,
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    FloatingActionButton(
                      heroTag: "add_item",
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => AddItemsDialog(
                            controller: controller,
                            itemGroupsCategory: controller.categories),
                      ),
                      child: const Icon(Icons.add),
                    ),
                  ],
                )
              : FloatingActionButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => AddItemsDialog(
                        controller: controller,
                        itemGroupsCategory: controller.categories),
                  ),
                  child: const Icon(Icons.add),
                )),
        ));
  }
}
