import 'package:flutter/material.dart';
import 'package:umc_finance/pages/signIn.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    Widget _buildPhoneNumber(){
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
            ]
        ),
        child: TextFormField(

          validator: (value){
            if(value == null || value.isEmpty){
              return "Enter your phone number";
            }
          },
          controller: emailController,
          decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14, left: 25, bottom: 10),
              hintText: "Enter your phone number"
          ),
        ),
      );
    }
    Widget _buildMembershipNumber(){
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
            ]
        ),
        child: TextFormField(

          validator: (value){
            if(value == null || value.isEmpty){
              return "Enter your membership number";
            }
          },
          controller: emailController,
          decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14, left: 25, bottom: 10),
              hintText: "Enter your membership number"
          ),
        ),
      );
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: size.height,
              width: size.width,
              child: Image.asset(
                "assets/banner.jpg",
                fit: BoxFit.fitHeight,
              ),

            ),
            Positioned(
              // width: size.width,
              // height: size.height ,
              top: 150,
              left: 20,
              right: 20,
              bottom: 100,
              child: Container(
                height: size.height,
                width: size.width,
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
                        fit: BoxFit.fitHeight,
                        height: 120,
                        width: 120,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Account Recovery",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
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
                          child: _buildPhoneNumber(),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_)=> const  SignIn()));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                            child: Text(
                              "Already have an account? Login",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FontStyle.italic
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 35),
                    ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.resolveWith((states) => const EdgeInsets.only(left: 110,top: 5, bottom: 5, right: 110)),
                        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.red),

                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> const  SignIn()));
                      },
                      child: const Padding(
                        padding:  EdgeInsets.fromLTRB(5, 10, 5, 10),
                        child: Text("Reset", style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            color: Colors.white
                        ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

            )
          ],
        ),
      ),
    );
  }
}
