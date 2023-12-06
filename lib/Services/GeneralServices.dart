import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umc_finance/Model/FinanceDescription.dart';
import 'package:umc_finance/Model/FinancialTargets.dart';
import 'package:umc_finance/Model/PaymentMethods.dart';
import 'package:umc_finance/Model/RecentTransactions.dart';
import '../Model/LocalFinances.dart';
import '../Model/api_response.dart';

class GeneralServices{

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
  // static const API = 'https://chitma.hushsoft.co.zw';
  static const API = 'http://192.168.100.136:8080';
  Future<APIResponse> getFinanceDescriptions() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Object? pp = prefs.get('local');
    try {
      Response response = await dio.get('$API/api/financeDescription/getAllFinanceDescriptions/$pp');
      List<FinanceDescription> financeDescription = (response.data as List).map((e) => FinanceDescription.fromJson(e as Map<String, dynamic>)).toList();
      return APIResponse(data: financeDescription);
    }catch(e, stacktrace){
      print(e);
      print(stacktrace);
      return APIResponse(error: true, errorMessage: 'An error has occurred.');
    }
  }
  Future<APIResponse> getPaymentMethods() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Object? pp = prefs.get('local');
    try {
      Response response = await dio.get('$API/api/paymentDetails/getPaymentDetailsBy/$pp');
      List<PaymentMethods> paymentMethods = (response.data as List).map((e) => PaymentMethods.fromJson(e as Map<String, dynamic>)).toList();
      return APIResponse(data: paymentMethods);
    }catch(e, stacktrace){
      print(e);
      print(stacktrace);
      return APIResponse(error: true, errorMessage: 'No Internet Connection');
    }
  }
  Future<APIResponse> getRecentTransactions() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Object? mN = prefs.get('membershipNumber');
    try {
      Response response = await dio.get('$API/api/statistics/getRecentTransactionsBy/$mN');
      List<RecentTransaction> recentTransactions = (response.data as List).map((e) => RecentTransaction.fromJson(e as Map<String, dynamic>)).toList();
      return APIResponse(data: recentTransactions);
    }catch(e, stacktrace){
      print(e);
      print(stacktrace);
      return APIResponse(error: true, errorMessage: 'No Internet Connection');
    }
  }
  Future<APIResponse> getFinancialTargets() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Object? pp = prefs.get('local');
    Object? mN = prefs.get('membershipNumber');
    try {
      Response response = await dio.get('$API/api/financialTargets/getAllBy$pp/And/{target}?target=P1&target=UMYF');
      List<FinancialTargets> financialTargets = (response.data as List).map((e) => FinancialTargets.fromJson(e as Map<String, dynamic>)).toList();
      return APIResponse(data: financialTargets);
    }catch(e, stacktrace){
      print(e);
      print(stacktrace);
      return APIResponse(error: true, errorMessage: 'No Internet Connection');
    }
  }
}


