import 'dart:convert';

import 'package:client/app/api/api_wrapper.dart';
import 'package:client/app/core/exception/exception.dart';
import 'package:client/app/core/helper/convert_helper.dart';
import 'package:client/app/data/models/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryApi {
  CategoryApi({required this.wrapper});

  final ApiWrapper wrapper;

  Future<List<CategoryModel>> getAll({int limit = 10, int offset = 1}) async {
    try {
      final query = ConvertHelper.mapToQueryString({
        'limit': limit,
        'offset': offset,
      });
      http.Response response = await wrapper.get("/category?$query");
      Map<String, dynamic> body = jsonDecode(response.body);
      String? message = body["message"];
      if (response.statusCode == 200) {
        return List<CategoryModel>.from(
          (body['data'] as List).map((item) => CategoryModel.fromJson(item)),
        );
      } else if (response.statusCode == 401) {
        throw UnauthorizedException(message ?? "Its Forbidden");
      } else {
        throw ServerException(message ?? "Something wrong with the server");
      }
    } catch (e) {
      throw ServerException("Something wrong with the server");
    }
  }

  Future<CategoryModel> getById({required int id}) async {
    try {
      http.Response response = await wrapper.get("/category/$id");
      Map<String, dynamic> body = jsonDecode(response.body);
      String? message = body["message"];
      if (response.statusCode == 200) {
        return CategoryModel.fromJson(body['data']);
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

  Future<void> createCategory({required CategoryModel category}) async {
    try {
      http.Response response = await wrapper.post("/category", body: {
        "category": category,
      });
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

  Future<void> deleteCategoryById({required int id}) async {
    try {
      http.Response response = await wrapper.delete("/category/$id");
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
