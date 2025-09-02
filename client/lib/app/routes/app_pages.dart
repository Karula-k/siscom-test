import 'package:get/get.dart';
import '../modules/items/bindings/item_binding.dart';
import '../modules/items/views/items_view.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.items;

  static final routes = [
    GetPage(
      name: _Paths.items,
      page: () => const ItemsView(),
      binding: ItemBinding(),
    ),
  ];
}

abstract class _Paths {
  _Paths._();

  static const home = '/home';
  static const items = '/items';
  static const categories = '/categories';
}
