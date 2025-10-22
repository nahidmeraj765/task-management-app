import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_task_management_app/ui/controllers/auth_controll.dart';
import 'package:http/http.dart';

class ApiCaller {
  Future<ApiResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      Response response = await get(uri, headers: {'token' : AuthController.accessToken ?? '' }).timeout(const Duration(seconds: 10));

      debugPrint(url);
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);

      final int statusCode = response.statusCode;
      final decodedData = jsonDecode(response.body);

      return ApiResponse(
        isSuccess: statusCode == 200,
        responseCode: statusCode,
        responseData: decodedData,
      );
    } on TimeoutException {
      return ApiResponse(
        isSuccess: false,
        responseCode: -1,
        responseData: null,
        errorMessage: "Request timed out",
      );
    } on Exception catch (e) {
      return ApiResponse(
        isSuccess: false,
        responseCode: -1,
        responseData: null,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<ApiResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      Response response = await post(
        uri,
        headers: {'content-type': 'application/json',
        'token' : AuthController.accessToken ?? '',
        },
        body: jsonEncode(body),
      ).timeout(const Duration(seconds: 10));

      debugPrint(url);
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);

      final int statusCode = response.statusCode;
      final decodedData = jsonDecode(response.body);

      return ApiResponse(
        isSuccess: statusCode == 200 || statusCode == 201,
        responseCode: statusCode,
        responseData: decodedData,
      );
    } on TimeoutException {
      return ApiResponse(
        isSuccess: false,
        responseCode: -1,
        responseData: null,
        errorMessage: "Request timed out",
      );
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
