import 'package:dio/dio.dart';
import 'package:test_app/core/appData.dart';
import 'package:test_app/models/userModel.dart';

class AuthNetwork {
  Dio _dio = Dio();

  login(userId, password) async {
    try {
      var response = await _dio.post('${AppData.baseURL}/auth/login',
          data: {"username": userId, "password": password});
      User _user = User.fromJson(response.data);
      AppData.user = _user;
      return 'ok';
    } catch (error) {
      if (error is DioError) {
        return error.response?.data ?? 'error!';
      }
      return 'error!';
    }
  }
}
