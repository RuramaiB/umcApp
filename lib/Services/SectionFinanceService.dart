import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umc_finance/Model/SectionFinances.dart';
import '../Model/api_response.dart';

class SectionFinanceServices{

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
  Future<APIResponse> getSectionFinanceList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Object? pp = prefs.get('local');
    Object? mN = prefs.get('membershipNumber');
    try {
      Response response = await dio.get('$API/api/sectionFinance/getSectionFinanceResponseBy/$mN');
      List<SectionFinances> sectionFinances = (response.data as List).map((e) => SectionFinances.fromJson(e as Map<String, dynamic>)).toList();
      return APIResponse(data: sectionFinances);
    }catch(e, stacktrace){
      print(e);
      print(stacktrace);
      return APIResponse(error: true, errorMessage: 'No Internet Connection');
    }
  }
  Future<APIResponse> sectionFinancePayment(SectionFinances item) async {
    try {
      Response response = await dio.post('$API/api/paynow/makeSectionFinance', data: item.toJson());
      print(response);
      return APIResponse(data: true);
    }catch(e, stacktrace){
      print(e);
      print(stacktrace);
      return APIResponse(error: true, errorMessage: 'No Internet Connection');
    }
  }
}


