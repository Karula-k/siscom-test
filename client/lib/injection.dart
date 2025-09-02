import 'package:client/app/api/api_wrapper.dart';
import 'package:client/app/api/category/category.api.dart';
import 'package:client/app/api/items/items.api.dart';
import 'package:client/app/data/repositories/category_repository.dart';
import 'package:client/app/data/repositories/item_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

Future<void> init() async {
  //repository
  locator
      .registerLazySingleton<CategoryRepositories>(() => CategoryRepositories(
            remoteDataSource: locator(),
          ));
  locator.registerLazySingleton<ItemsRepositories>(
      () => ItemsRepositories(remoteDataSource: locator()));

  //datasources

  locator.registerLazySingleton<ItemsApi>(() => ItemsApi(wrapper: locator()));
  locator.registerLazySingleton<CategoryApi>(
      () => CategoryApi(wrapper: locator()));
  locator.registerLazySingleton<ApiWrapper>(() => ApiWrapper(
        client: locator(),
      ));

  //external

  locator.registerLazySingleton<http.Client>(() => http.Client());
}
