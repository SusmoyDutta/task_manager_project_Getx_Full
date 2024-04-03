import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager_project/data/models/response_object.dart';
import 'package:task_manager_project/presentation/App.dart';
import 'package:task_manager_project/presentation/controllers/auth_controllers.dart';
import 'package:task_manager_project/presentation/screen/auth/Sing_in_screen.dart';

class NetWorkCaller {
  static Future<ResponseObject> getRequest(String url) async {
    try {
      log(AuthController.accessToken.toString());
      final Response response = await get(Uri.parse(url), headers: {
        'token': AuthController.accessToken ?? '',
        //token set kora holo get responce er vitore.
      });
      log(response.request.toString());
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        final decodeResponce = jsonDecode(response.body);
        return ResponseObject(
          isSuccess: true,
          statusCode: 200,
          responseBody: decodeResponce,
        );
      } else if (response.statusCode == 401) {
        _moveToSingIn();
        return ResponseObject(
            isSuccess: false,
            statusCode: response.statusCode,
            responseBody: '');
      } else {
        return ResponseObject(
            isSuccess: false,
            statusCode: response.statusCode,
            responseBody: '');
      }
    } catch (e) {
      log(e.toString());
      return ResponseObject(
        isSuccess: false,
        statusCode: -1,
        responseBody: '',
        errorMessage: e.toString(),
      );
    }
  }

  static Future<ResponseObject> postRequest(
      String url, Map<String, dynamic> body,
      {bool fromSinIn = false}) async {
    try {
      final Response response = await post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          'Content-type': 'application/json',
          'token': AuthController.accessToken ?? ''
          //toke set kora holo post request er vi tore
        },
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        final encodeResponce = jsonDecode(response.body);
        return ResponseObject(
          isSuccess: true,
          statusCode: 200,
          responseBody: encodeResponce,
        );
      } else if (response.statusCode == 401) {
        if (fromSinIn) {
          return ResponseObject(
              isSuccess: false,
              statusCode: response.statusCode,
              responseBody: ' Email/password is incorrect Try again');
        } else {
          _moveToSingIn();
          return ResponseObject(
            isSuccess: false,
            statusCode: response.statusCode,
            responseBody: '',
          );
        }
      } else {
        return ResponseObject(
          isSuccess: false,
          statusCode: response.statusCode,
          responseBody: '',
        );
      }
    } catch (e) {
      log(e.toString());
      return ResponseObject(
        isSuccess: false,
        statusCode: -1,
        responseBody: '',
      );
    }
  }

  static Future<void> _moveToSingIn() async {
    await AuthController.clearUserData();
    Navigator.pushAndRemoveUntil(
        TaskManager.navigatorKey.currentState!.context,
        MaterialPageRoute(
          builder: (context) => const SingIn(),
        ),
        (route) => false);
  }
}
