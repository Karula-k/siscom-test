import 'dart:convert';

import 'package:client/app/api/api_wrapper.dart';
import 'package:client/app/core/exception/exception.dart';
import 'package:client/app/core/helper/convert_helper.dart';
import 'package:client/app/data/models/item_model.dart';
import 'package:client/app/data/models/item_update_model.dart';
import 'package:http/http.dart' as http;

class ItemsApi {
  ItemsApi({required this.wrapper});

  final ApiWrapper wrapper;

  Future<List<ItemModel>> getAll({int limit = 10, int offset = 1}) async {
    try {
      final query = ConvertHelper.mapToQueryString({
        'limit': limit,
        'offset': offset,
      });
      http.Response response = await wrapper.get("/items?$query");
      Map<String, dynamic> body = jsonDecode(response.body);
      String? message = body["message"];
      if (response.statusCode == 200) {
        if (body['data'] is List) {
          return List<ItemModel>.from(
            (body['data'] as List).map((item) => ItemModel.fromJson(item)),
          );
        } else {
          throw ServerException("Unexpected data format");
        }
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(message ?? "Its Forbidden");
      } else {
        throw ServerException(message ?? "Something wrong with the server");
      }
    } catch (e) {
      throw ServerException("Something wrong with the server");
    }
  }

  Future<ItemModel> getById({required int id}) async {
    try {
      http.Response response = await wrapper.get("/items/$id");
      Map<String, dynamic> body = jsonDecode(response.body);
      String? message = body["message"];
      if (response.statusCode == 200) {
        return ItemModel.fromJson(body['data']);
      } else if (response.statusCode == 400) {
        throw UnauthorizedException(message ?? "User Bad Request");
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(message ?? "Its Forbidden");
      } else {
        throw ServerException(message ?? "Something wrong with the server");
      }
    } catch (e) {
      throw ServerException("Something wrong with the server");
    }
  }

  Future<void> createItem({required ItemUpdateModel item}) async {
    try {
      http.Response response = await wrapper.post(
        "/items",
        body: jsonEncode(item.toJson()),
      );
      Map<String, dynamic> body = jsonDecode(response.body);
      String? message = body["message"];
      if (response.statusCode == 201) {
        return;
      } else if (response.statusCode == 400) {
        throw UnauthorizedException(message ?? "User Bad Request");
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(message ?? "Its Forbidden");
      } else {
        throw ServerException(message ?? "Something wrong with the server");
      }
    } catch (e) {
      throw ServerException("Something wrong with the server");
    }
  }

  Future<void> updateItem(
      {required ItemUpdateModel item, required int id}) async {
    try {
      http.Response response = await wrapper.put(
        "/items/$id",
        body: jsonEncode(item.toJson()),
      );
      Map<String, dynamic> body = jsonDecode(response.body);
      String? message = body["message"];
      if (response.statusCode == 201) {
        return;
      } else if (response.statusCode == 400) {
        throw UnauthorizedException(message ?? "User Bad Request");
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(message ?? "Its Forbidden");
      } else {
        throw ServerException(message ?? "Something wrong with the server");
      }
    } catch (e) {
      throw ServerException("Something wrong with the server");
    }
  }

  Future<void> deleteItemById({required int id}) async {
    try {
      http.Response response = await wrapper.delete("/items/$id");
      Map<String, dynamic> body = jsonDecode(response.body);
      String? message = body["message"];
      if (response.statusCode == 200) {
        return;
      } else if (response.statusCode == 400) {
        throw UnauthorizedException(message ?? "User Bad Request");
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(message ?? "Its Forbidden");
      } else {
        throw ServerException(message ?? "Something wrong with the server");
      }
    } catch (e) {
      throw ServerException("Something wrong with the server");
    }
  }

  Future<void> deleteItems({required List<int> ids}) async {
    try {
      // List<String> stringIds = ids.map((id) => id.toString()).toList();
      Map<String, List<int>> bodyIds = {
        "ids": ids,
      };
      http.Response response =
          await wrapper.delete("/items/list", body: json.encode(bodyIds));
      Map<String, dynamic> body = jsonDecode(response.body);
      String? message = body["message"];
      if (response.statusCode == 200) {
        return;
      } else if (response.statusCode == 400) {
        throw UnauthorizedException(message ?? "User Bad Request");
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(message ?? "Its Forbidden");
      } else {
        throw ServerException(message ?? "Something wrong with the server");
      }
    } catch (e) {
      throw ServerException("Something wrong with the server");
    }
  }
}
