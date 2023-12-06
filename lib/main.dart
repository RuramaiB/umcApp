import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:umc_finance/Services/GeneralServices.dart';
import 'package:umc_finance/Services/LocalFinanceService.dart';
import 'package:umc_finance/Services/OrganisationFinanceService.dart';
import 'package:umc_finance/Services/PledgesServices.dart';
import 'package:umc_finance/Services/SectionFinanceService.dart';
import 'package:umc_finance/Services/UsersService.dart';
import 'package:umc_finance/pages/SplashScreen.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<LocalFinanceServices>(LocalFinanceServices());
  locator.registerSingleton<SectionFinanceServices>(SectionFinanceServices());
  locator.registerSingleton<OrganisationFinanceServices>(OrganisationFinanceServices());
  locator.registerSingleton<PledgesFinanceServices>(PledgesFinanceServices());
  locator.registerSingleton<UsersService>(UsersService());
  locator.registerSingleton<GeneralServices>(GeneralServices());
}
void main() {
  setupLocator();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

