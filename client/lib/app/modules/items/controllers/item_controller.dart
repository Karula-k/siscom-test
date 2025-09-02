import 'package:client/app/data/models/category_model.dart';
import 'package:client/app/data/models/item_model.dart';
import 'package:client/app/data/models/item_update_model.dart';
import 'package:client/app/data/repositories/category_repository.dart';
import 'package:client/app/data/repositories/item_repository.dart';
import 'package:get/get.dart';

class ItemController extends GetxController {
  final RxList<ItemModel> items = <ItemModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxString error = ''.obs;
  final RxInt currentPage = 1.obs;
  final RxBool hasMoreData = true.obs;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;

  // Checkbox selection functionality
  final RxList<int> selectedItemIds = <int>[].obs;
  final RxBool isSelectionMode = false.obs;

  final ItemsRepositories itemsRepositories;
  final CategoryRepositories categoryRepositories;

  ItemController({
    required this.itemsRepositories,
    required this.categoryRepositories,
  });
  final int pageSize = 10;

  @override
  void onInit() {
    super.onInit();
    loadItems();
    loadCategories();
  }

  Future<void> loadItems({bool refresh = false}) async {
    if (refresh) {
      currentPage.value = 1;
      hasMoreData.value = true;
      items.clear();
    }

    if (!hasMoreData.value) return;

    try {
      if (currentPage.value == 1) {
        isLoading.value = true;
      } else {
        isLoadingMore.value = true;
      }

      error.value = '';
      final output = await itemsRepositories.getItems(
        limit: pageSize,
        offset: currentPage.value,
      );
      output.fold((failure) {
        error.value = failure.message;
        Get.snackbar(
          'Error',
          'Failed to load items: ${failure.message}',
          snackPosition: SnackPosition.BOTTOM,
        );
      }, (responses) {
        if (responses.length < pageSize) {
          hasMoreData.value = false;
        }
        if (refresh) {
          items.assignAll(responses);
        } else {
          items.addAll(responses);
        }
        currentPage.value++;
      });
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  Future<void> loadCategories() async {
    isLoading.value = true;
    error.value = '';

    try {
      final output = await categoryRepositories.getCategories();
      output.fold((failure) {
        error.value = failure.message;
      }, (responses) {
        categories.assignAll(responses);
      });
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshItems() async {
    await loadItems(refresh: true);
  }

  Future<void> loadMoreItems() async {
    if (!isLoadingMore.value && hasMoreData.value) {
      await loadItems();
    }
  }

  Future<ItemModel?> getItemById(int id) async {
    isLoading.value = true;
    error.value = '';

    final output = await itemsRepositories.getItemById(id: id);
    output.fold((failure) {
      error.value = failure.message;
      isLoading.value = false;
      return null;
    }, (response) {
      return response;
    });
    return null;
  }

  // Create new item
  Future<bool> createItem(ItemUpdateModel itemData) async {
    isLoading.value = true;
    error.value = '';

    final output = await itemsRepositories.createItems(item: itemData);
    output.fold((failure) {
      error.value = failure.message;
      isLoading.value = false;
      return false;
    }, (response) {
      refreshItems();
      isLoading.value = false;
      return true;
    });
    return false;
  }

  // Update item
  Future<bool> updateItem(
      {required ItemUpdateModel itemData, required int id}) async {
    try {
      isLoading.value = true;
      error.value = '';
      final output =
          await itemsRepositories.updateItems(item: itemData, id: id);
      output.fold((failure) {
        error.value = failure.message;
        isLoading.value = false;
        isLoading.value = false;
        return false;
      }, (response) {
        refreshItems();
        isLoading.value = false;
        return true;
      });
      return false;
    } catch (e) {
      error.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Delete item
  Future<bool> deleteItem(int id) async {
    isLoading.value = true;
    error.value = '';

    final output = await itemsRepositories.deleteItemById(id: id);

    output.fold((failure) {
      error.value = failure.message;
      Get.snackbar(
        'Error',
        'Failed to load items: ${failure.message}',
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoading.value = false;
      isLoading.value = false;
      return false;
    }, (response) {
      refresh();
      Get.snackbar(
        'Success',
        'Item deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoading.value = false;
      return true;
    });

    return false;
  }

  void toggleItemSelection(int itemId) {
    if (selectedItemIds.contains(itemId)) {
      selectedItemIds.remove(itemId);
    } else {
      selectedItemIds.add(itemId);
    }

    if (selectedItemIds.isEmpty) {
      isSelectionMode.value = false;
    }
  }

  void toggleSelectionMode() {
    isSelectionMode.value = !isSelectionMode.value;
    if (!isSelectionMode.value) {
      selectedItemIds.clear();
    }
  }

  void selectAllItems() {
    selectedItemIds.clear();
    selectedItemIds.addAll(items.map((item) => item.id));
  }

  void clearSelection() {
    selectedItemIds.clear();
    isSelectionMode.value = false;
  }

  bool isItemSelected(int itemId) {
    return selectedItemIds.contains(itemId);
  }

  // Batch delete selected items
  Future<bool> deleteSelectedItems() async {
    if (selectedItemIds.isEmpty) return false;

    isLoading.value = true;
    error.value = '';
    try {
      final output = await itemsRepositories.deleteItems(ids: selectedItemIds);
         output.fold((failure) {
        error.value = failure.message;
        isLoading.value = false;
        return false;
      }, (response) {
        refreshItems();
        isLoading.value = false;
        return true;
      });
      return false;
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
