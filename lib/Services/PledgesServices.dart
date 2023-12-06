import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umc_finance/Model/Pledges.dart';
import '../Model/LocalFinances.dart';
import '../Model/api_response.dart';

class PledgesFinanceServices{

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
  Future<APIResponse> getPledgesList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Object? pp = prefs.get('local');
    Object? mN = prefs.get('membershipNumber');
    try {
      Response response = await dio.get('$API/api/pledges/getPledgesBy/$mN');
      List<Pledges> listings = (response.data as List).map((e) => Pledges.fromJson(e as Map<String, dynamic>)).toList();
      return APIResponse(data: listings);
    }catch(e, stacktrace){
      print(e);
      print(stacktrace);
      return APIResponse(error: true, errorMessage: 'No Internet Connection');
    }
  }
  Future<APIResponse> pledgesPayment(Pledges item) async {
    try {
      Response response = await dio.post('$API/api/paynow/makePledge', data: item.toJson());
      return APIResponse(data: true);
    }catch(e, stacktrace){
      print(e);
      print(stacktrace);
      return APIResponse(error: true, errorMessage: 'No Internet Connection');
    }
  }
}


