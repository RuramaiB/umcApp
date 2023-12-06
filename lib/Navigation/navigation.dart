import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:umc_finance/Services/GeneralServices.dart';
import 'package:umc_finance/pages/Settings.dart';
import 'package:umc_finance/pages/Home.dart';
import 'package:umc_finance/pages/Transactions.dart';
import 'package:umc_finance/pages/Payments.dart';

import '../Services/UsersService.dart';



class NavigationController extends GetxController{
  RxInt index = 0.obs;
  var pages =  [
    Home(generalServices: GetIt.I<GeneralServices>(),),
    Transactions(),
    Payments(),
    Settings(usersService: GetIt.I<UsersService>())
  ];
}