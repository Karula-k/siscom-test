import 'package:get/get.dart';
import '../../../data/models/item_model.dart';
import '../../../data/repositories/item_repository.dart';

class ItemController extends GetxController {
  // Observable variables
  final RxList<ItemModel> items = <ItemModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxString error = ''.obs;
  final RxInt currentPage = 0.obs;
  final RxBool hasMoreData = true.obs;

  // Pagination
  final int pageSize = 10;

  @override
  void onInit() {
    super.onInit();
    loadItems();
  }

  // Load items with pagination
  Future<void> loadItems({bool refresh = false}) async {
    if (refresh) {
      currentPage.value = 0;
      hasMoreData.value = true;
      items.clear();
    }

    if (!hasMoreData.value) return;

    try {
      if (currentPage.value == 0) {
        isLoading.value = true;
      } else {
        isLoadingMore.value = true;
      }

      error.value = '';

      final newItems = await ItemRepository.getItems(
        limit: pageSize,
        skip: currentPage.value * pageSize,
      );

      if (newItems.isEmpty) {
        hasMoreData.value = false;
      } else {
        if (refresh) {
          items.assignAll(newItems);
        } else {
          items.addAll(newItems);
        }
        currentPage.value++;
      }
    } catch (e) {
      error.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to load items: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  // Refresh items
  Future<void> refreshItems() async {
    await loadItems(refresh: true);
  }

  // Load more items
  Future<void> loadMoreItems() async {
    if (!isLoadingMore.value && hasMoreData.value) {
      await loadItems();
    }
  }

  // Get item by ID
  Future<ItemModel?> getItemById(int id) async {
    try {
      isLoading.value = true;
      error.value = '';

      final item = await ItemRepository.getItemById(id);
      return item;
    } catch (e) {
      error.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to load item: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  // Create new item
  Future<bool> createItem(Map<String, dynamic> itemData) async {
    try {
      isLoading.value = true;
      error.value = '';

      final newItem = await ItemRepository.createItem(itemData);
      items.insert(0, newItem);

      Get.snackbar(
        'Success',
        'Item created successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } catch (e) {
      error.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to create item: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Update item
  Future<bool> updateItem(int id, Map<String, dynamic> itemData) async {
    try {
      isLoading.value = true;
      error.value = '';

      final updatedItem = await ItemRepository.updateItem(id, itemData);

      final index = items.indexWhere((item) => item.id == id);
      if (index != -1) {
        items[index] = updatedItem;
      }

      Get.snackbar(
        'Success',
        'Item updated successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } catch (e) {
      error.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to update item: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Delete item
  Future<bool> deleteItem(int id) async {
    try {
      isLoading.value = true;
      error.value = '';

      final success = await ItemRepository.deleteItem(id);

      if (success) {
        items.removeWhere((item) => item.id == id);
        Get.snackbar(
          'Success',
          'Item deleted successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      }

      return success;
    } catch (e) {
      error.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to delete item: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
