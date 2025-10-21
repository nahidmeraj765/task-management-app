import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ApiCaller {
  Future<ApiResponse> getRequest({required String url}) async {
    
    try{
    Uri uri = Uri.parse(url);
    Response response = await get(uri);

    debugPrint(url);
    debugPrint(response.statusCode as String?);
    debugPrint(response.body);

    final int statusCode = response.statusCode;

    if (statusCode == 200) {
      final decodedData = jsonDecode(response.body);

      return ApiResponse(
        isSuccess: true,
        responseCode: statusCode,
        responseData: decodedData,
      );
    }
    else {
      final decodedData = jsonDecode(response.body);

      return ApiResponse(
        isSuccess: false,
        responseCode: statusCode,
        responseData: decodedData,
      );
    }
    } on Exception catch (e) {
    return ApiResponse(
        isSuccess: false,
        responseCode: -1,
        responseData: null,
        errorMessage: e.toString(),
      );
}
    
  }
  static Future<ApiResponse> postRequest({required String url, Map<String,dynamic>? body}) async {

  try {
  Uri uri = Uri.parse(url);
  Response response = await post(uri, headers: {'content-type': 'application/json'}, body: jsonEncode(body));

    debugPrint(url);
    debugPrint(response.statusCode as String?);
    debugPrint(response.body);

    final int statusCode = response.statusCode;

    if (response.statusCode == 200 || statusCode == 201) {
      final decodedData = jsonDecode(response.body);

      return ApiResponse(
        isSuccess: true,
        responseCode: statusCode,
        responseData: decodedData,
      );
    }
    else {
      final decodedData = jsonDecode(response.body);

      return ApiResponse(
        isSuccess: false,
        responseCode: statusCode,
        responseData: decodedData,
      );
    }
} on Exception catch (e) {
    return ApiResponse(
        isSuccess: false,
        responseCode: -1,
        responseData: null,
        errorMessage: e.toString(),
      );
} 
  }
}

class ApiResponse {
  final bool isSuccess;
  final int responseCode;
  final dynamic responseData;
  final String? errorMessage;

  ApiResponse({
    required this.isSuccess,
    required this.responseCode,
    required this.responseData,
    this.errorMessage,
  });
}
