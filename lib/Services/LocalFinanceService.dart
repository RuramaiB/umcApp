import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/LocalFinances.dart';
import '../Model/api_response.dart';

class LocalFinanceServices{

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
  Future<APIResponse> getLocalFinanceList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Object? pp = prefs.get('local');
    Object? mN = prefs.get('membershipNumber');
    try {
      Response response = await dio.get('$API/api/localFinance/getLocalFinanceResponseByMembership/$mN');
      List<LocalFinances> listings = (response.data as List).map((e) => LocalFinances.fromJson(e as Map<String, dynamic>)).toList();
      return APIResponse(data: listings);
    }catch(e, stacktrace){
      print(e);
      print(stacktrace);
      return APIResponse(error: true, errorMessage: 'No Internet Connection');
    }
  }
  Future<APIResponse> localFinancePayment(LocalFinances item) async {
    try {
      Response response = await dio.post('$API/api/paynow/makeLocalFinance', data: item.toJson());
      print(response);
      return APIResponse(data: true);
    }catch(e, stacktrace){
      print(e);
      print(stacktrace);
      return APIResponse(error: true, errorMessage: 'No Internet Connection');
    }
  }
}


