import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:test_app/core/appData.dart';
import 'package:test_app/models/summyModel.dart';

class SummyNetwork {
  final Dio _dio = Dio();

  uploadFile(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename: fileName),
      });
      Options _options = Options(headers: {
        "token": "Bearer ${AppData.user.accessToken}",
      });
      AppData.myextracted = '';
      var response = await _dio.put('${AppData.baseURL}/extracttext',
          data: formData, options: _options);
      AppData.myextracted = response.data['myextracted'] ?? '';
      return 'ok';
    } catch (error) {
      if (error is DioError) {
        return error.response?.data ?? 'error!';
      }
      return 'error!';
    }
  }

  getSummary(String title, String text) async {
    try {
      Options _options = Options(headers: {
        "Content-Type": "application/json",
        "token": "Bearer ${AppData.user.accessToken}",
      });
      var _data = {
        'title': title == '' ? 'no-title' : title,
        'summary': text,
      };
      AppData.mysummary = '';
      var response = await _dio.post(
        '${AppData.baseURL}/summy',
        data: jsonEncode(_data),
        options: _options,
      );
      AppData.mysummary = response.data['summary'] ?? '';
      return 'ok';
    } catch (error) {
      if (error is DioError) {
        return error.response?.data ?? 'error!';
      }
      return 'error!';
    }
  }

  summyHistory() async {
    try {
      Options _options = Options(headers: {
        "token": "Bearer ${AppData.user.accessToken}",
      });
      //AppData.mysummary = '';
      var response = await _dio.get(
        '${AppData.baseURL}/user/history/summary',
        options: _options,
      );
      AppData.summyHistory = List.generate(
        response.data.length,
        (index) => Summy.fromJson(response.data[index]),
      );
      //AppData.mysummary = response.data['summary'] ?? '';
      return 'ok';
    } catch (error) {
      if (error is DioError) {
        return error.response?.data ?? 'error!';
      }
      return 'error!';
    }
  }
}
