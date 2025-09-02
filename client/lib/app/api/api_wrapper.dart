import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ApiWrapper {
  static const base = String.fromEnvironment('url');
  ApiWrapper({required this.client});

  final http.Client client;
  Map<String, String> get header {
    return {
      "Content-Type": "application/json",
    };
  }

  Future<http.Response> get(
    String url,
  ) async {
    http.Response response =
        await client.get(Uri.parse("$base$url"), headers: header);

    return response;
  }

  Future<http.Response> post(
    String url, {
    Object? body,
  }) async {
    http.Response response = await client.post(
      Uri.parse("$base$url"),
      body: body,
      headers: header,
    );

    return response;
  }

  Future<http.Response> put(
    String url, {
    Object? body,
  }) async {
    http.Response response = await client.put(
      Uri.parse("$base$url"),
      body: body,
      headers: header,
    );

    return response;
  }

  Future<http.Response> patch(
    String url, {
    Object? body,
  }) async {
    http.Response response = await client.patch(
      Uri.parse("$base$url"),
      body: body,
      headers: header,
    );

    return response;
  }

  Future<http.Response> delete(String url, {Object? body}) async {
    http.Response response = await client.delete(
      Uri.parse("$base$url"),
      body: body,
      headers: header,
    );

    return response;
  }

  Future<http.StreamedResponse> uploadImage(String url,
      {required File image, String type = "PUT"}) async {
    http.MultipartRequest request =
        http.MultipartRequest(type, Uri.parse("$base$url"))
          ..files.add(await http.MultipartFile.fromPath("file", image.path,
              filename: "image.png", contentType: MediaType('image', 'jpeg')));

    http.StreamedResponse response = await request.send();

    return response;
  }
}
