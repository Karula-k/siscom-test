import 'package:client/app/modules/items/controllers/item_controller.dart';
import 'package:get/get.dart';
import 'package:client/injection.dart' as di;

class BindingInjection implements Bindings {
  //STATE MANAGEMENT
  @override
  void dependencies() {
    Get.lazyPut<ItemController>(
        () => ItemController(
            itemsRepositories: di.locator(),
            categoryRepositories: di.locator()),
        fenix: true);
  }
}
