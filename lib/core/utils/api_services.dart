import 'dart:developer';

import 'package:dio/dio.dart';

class ApiServise {
  final Dio _dio;
  final baseUrl = "https://www.googleapis.com/books/v1/";

  ApiServise(this._dio);

  Future<Map<String,dynamic>> get({required String endpoint}) async {
    var response = await _dio.get('$baseUrl$endpoint');

    return response.data;
  }
}
class AuthApiServise {
  final Dio _dio;

  AuthApiServise(this._dio);

  Future<Map<String,dynamic>> get({required String url}) async {
    var response = await _dio.get(url);

    return response.data;
  }

  Future<dynamic> post(
      {required String url, dynamic body}) async {
   // Map<String, String> body = {};

    
    log('url = $url body = $body ');

    var response = await _dio.post(
      url,
      data: body,
    );

   if (response.statusCode == 200) {
      log('User created successfully');
      log(response.data);
    } else {
      log('Failed to create user');
    }
  }
}
