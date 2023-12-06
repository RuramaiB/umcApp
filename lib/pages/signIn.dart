import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umc_finance/Services/UsersService.dart';
import 'package:umc_finance/pages/forgotPassword.dart';
import '../Model/UserModel.dart';
import '../Navigation/DashboardBinding.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController membershipNumberController = TextEditingController();
    final UsersService usersService = UsersService();

    Widget _buildMembershipNumber() {
      return Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: const Offset(3, 3),
              blurRadius: 6,
              color: Colors.grey.shade400,
            ),
          ],
        ),
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter your membership number";
            }
          },
          controller: membershipNumberController,
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14, left: 25, bottom: 10),
            hintText: "Enter your membership number",
          ),
        ),
      );
    }

    Widget _buildPassword() {
      return Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: const Offset(3, 3),
              blurRadius: 6,
              color: Colors.grey.shade400,
            ),
          ],
        ),
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Enter your password";
            }
          },
          controller: passwordController,
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14, left: 25, bottom: 10),
            hintText: "Enter your password",
          ),
        ),
      );
    }

    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      "assets/banner.jpg",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.1,
                    left: 20,
                    right: 20,
                    bottom: MediaQuery.of(context).size.height * 0.15,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: Image.asset(
                              "assets/logo.png",
                              // fit: BoxFit.fitHeight,
                              height: 145,
                              width: 145,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Welcome to UMC Finance Login",
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: _buildMembershipNumber(),
                          ),
                          const SizedBox(height: 25),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: _buildPassword(),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const ForgotPassword(),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 30),
                                  child: Text(
                                    "Forgot Password",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: MediaQuery.of(context).size.width * 0.03,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          ElevatedButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.resolveWith(
                                    (states) => EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * 0.2,
                                  top: 5,
                                  bottom: 5,
                                  right: MediaQuery.of(context).size.width * 0.2,
                                ),
                              ),
                              backgroundColor:
                              MaterialStateColor.resolveWith((states) => Colors.red),
                            ),
                            onPressed: () async {
                              UserModel user = UserModel(
                                  membershipNumber: membershipNumberController.text,
                                  password: passwordController.text
                              );
                              final result = await usersService.login(user);
                              Map<String, dynamic> resultData = result.data;

// Access membershipNumber and local
                              String membershipNumber = resultData['membershipNumber'];
                              String local = resultData['local'];

                              print('Membership Number: $membershipNumber');
                              print('Local: $local');
                              if (result.statusCode == 200) {
                                // Save user data using SharedPreferences
                                final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                                prefs.setString('membershipNumber',membershipNumber);
                                prefs.setString('local', local);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const Home(),
                                  ),
                                );
                              } else {
                                // Show error message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Login failed"),
                                  ),
                                );
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            // Handle landscape mode if needed
            return Center(
              child: Text("Landscape mode is not supported"),
            );
          }
        },
      ),
    );
  }
}
