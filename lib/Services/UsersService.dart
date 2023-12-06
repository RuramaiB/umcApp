import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umc_finance/Model/UserModel.dart';
import 'package:umc_finance/Model/Users.dart';

import '../Model/api_response.dart';


class UsersService{

  final Dio dio = Dio()
    ..interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
      ),
    );
  static const API = 'https://chitma.hushsoft.co.zw';
  // static const API = 'http://192.168.100.136:8080';
  Future<APIResponse> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Object? mN = prefs.get('membershipNumber');
    try {
      Response response = await dio.get('$API/api/api/v1/auth/getUserByMembershipNumber/$mN');
      Users user = Users.fromJson(response.data);
      return APIResponse(data: user);
    }catch(e, stacktrace){
      print(e);
      print(stacktrace);
      return APIResponse(error: true, errorMessage: 'No Internet Connection');
    }
  }
  Future<APIResponse> updateProfile(Users item) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Object? mN = prefs.get('membershipNumber');
    try {
      Response response = await dio.put('$API/api/api/v1/auth/updateUserByMembershipNumber(primary)/$mN', data: item.toJson());
      return APIResponse(data: response);
    }catch(e, stacktrace){
      print(e);
      print(stacktrace);
      return APIResponse(error: true, errorMessage: 'No Internet Connection');
    }
  }
  Future<APIResponse> login(UserModel item) async {
    try {
      Response response = await dio.post('$API/api/api/v1/auth/login', data: item.toJson());
      return APIResponse(data: response.data, statusCode: response.statusCode);
    }catch(e, stacktrace){
      print(e);
      print(stacktrace);
      return APIResponse(error: true, errorMessage: 'Login Failed. No Internet Connection.');
    }
  }
}


