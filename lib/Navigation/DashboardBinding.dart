import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:umc_finance/Navigation/navigation.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    NavigationController controller = Get.put(NavigationController());
    return  Scaffold(
      bottomNavigationBar: Container(
        color: Colors.white,
        child:  Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: GNav(
            gap: 5,
              backgroundColor: Colors.white,
              color: Colors.black,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.black,
              padding: const EdgeInsets.all(15),
              onTabChange: (value){
                controller.index.value = value;
              },
              tabs: const [
                GButton(
                    icon: Icons.home,
                  text: "Home",

                ),
                GButton(
                  icon: Icons.payments,
                  text: "Transactions",
                ),
                GButton(
                  icon: Icons.payment,
                  text: "Payments",
                ),
                GButton(
                  icon: Icons.person,
                  text: "Profile",
                ),
              ]
          ),
        ),
      ),
      body: Obx(
          () => controller.pages[controller.index.value]
      ),
    );
  }
}
