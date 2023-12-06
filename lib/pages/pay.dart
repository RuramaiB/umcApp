import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Payments extends StatefulWidget {
  const Payments({super.key});

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  List<String> tabs = [
    "Local",
    "Section",
    "Organisation",
    "Pledge"
  ];
  int current = 0;
  double changeLinePosition(){
    switch (current){
      case 0:
        return 0;
      case 1:
        return 60;
      case 2:
        return 130;
      case 3:
        return 230;
      default:
        return 0;
    }
  }
  double changeLineWidth(){
    switch (current){
      case 0:
        return 60;
      case 1:
        return 70;
      case 2:
        return 100;
      case 3:
        return 60;
      default:
        return 0;
    }
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var passwordController = TextEditingController();
    Widget _buildDescription(){
      return Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
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
              return "Enter payment description";
            }
          },
          controller: passwordController,
          decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14, left: 25, bottom: 10),
              hintText: "Enter payment description"
          ),
        ),
      );
    }
    Widget _buildPledgeDescription(){
      return Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
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
              return "Enter pledge description";
            }
          },
          controller: passwordController,
          decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14, left: 25, bottom: 10),
              hintText: "Enter pledge description"
          ),
        ),
      );
    }
    Widget _buildSection(){
      return Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
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
              return "Enter section";
            }
          },
          controller: passwordController,
          decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14, left: 25, bottom: 10),
              hintText: "Enter section"
          ),
        ),
      );
    }
    Widget _buildOrganisation(){
      return Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
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
              return "Enter organisation";
            }
          },
          controller: passwordController,
          decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14, left: 25, bottom: 10),
              hintText: "Enter organisation"
          ),
        ),
      );
    }
    Widget _buildPaymentMethod(){
      return Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
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
              return "Select payment method";
            }
          },
          controller: passwordController,
          decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14, left: 25, bottom: 10),
              hintText: "Select payment method"
          ),
        ),
      );
    }
    Widget _buildCurrency(){
      return Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
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
              return "Select currency";
            }
          },
          controller: passwordController,
          decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14, left: 25, bottom: 10),
              hintText: "Select currency"
          ),
        ),
      );
    }
    Widget _buildAmount(){
      return Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: const Offset(3, 3),
                blurRadius: 6,
                color: Colors.grey.shade400,
              ),
            ]
        ),
        child:
        TextFormField(

          validator: (value){
            if(value == null || value.isEmpty){
              return "Enter your amount";
            }
          },
          controller: passwordController,
          decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14, left: 25, bottom: 10),
              hintText: "Enter your amount"
          ),
        ),
      );
    }
    Widget Localforms(){
      return SingleChildScrollView(
        child:  Padding(
          padding: const EdgeInsets.symmetric(vertical: 40,),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Make a ${tabs[current].toLowerCase()} finance payment now.",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildDescription(),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildCurrency(),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildPaymentMethod(),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildAmount(),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.resolveWith((states) => const EdgeInsets.only(left: 110,top: 5, bottom: 5, right: 110)),
                  backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black),

                ),
                onPressed: (){
                },
                child: const Padding(
                  padding:  EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child: Text("Submit", style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Colors.white
                  ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      );
    }
    Widget Sectionform(){
      return SingleChildScrollView(
        child:  Padding(
          padding: const EdgeInsets.symmetric(vertical: 40,),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Make a ${tabs[current].toLowerCase()} payment now.",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildSection(),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildDescription(),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildCurrency(),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildPaymentMethod(),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildAmount(),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.resolveWith((states) => const EdgeInsets.only(left: 110,top: 5, bottom: 5, right: 110)),
                  backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black),

                ),
                onPressed: (){
                },
                child: const Padding(
                  padding:  EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child: Text("Submit", style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Colors.white
                  ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      );
    }
    Widget Organisationform(){
      return SingleChildScrollView(
        child:  Padding(
          padding: const EdgeInsets.symmetric(vertical: 40,),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Make a ${tabs[current].toLowerCase()} payment now.",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildOrganisation(),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildDescription(),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildCurrency(),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildPaymentMethod(),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildAmount(),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.resolveWith((states) => const EdgeInsets.only(left: 110,top: 5, bottom: 5, right: 110)),
                  backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black),

                ),
                onPressed: (){
                },
                child: const Padding(
                  padding:  EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child: Text("Submit", style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Colors.white
                  ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      );
    }
    Widget Pledgeform(){
      return SingleChildScrollView(
        child:  Padding(
          padding: const EdgeInsets.symmetric(vertical: 40,),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Make a ${tabs[current].toLowerCase()} now.",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildPledgeDescription(),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildCurrency(),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildPaymentMethod(),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildAmount(),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.resolveWith((states) => const EdgeInsets.only(left: 110,top: 5, bottom: 5, right: 110)),
                  backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black),

                ),
                onPressed: (){
                },
                child: const Padding(
                  padding:  EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child: Text("Submit", style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Colors.white
                  ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Payments",
          style: TextStyle(
              color: Colors.white
          ),
        ),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            SizedBox(
              width: size.width,
              height: size.height * 0.05,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      width: size.width,
                      height: size.height *0.04,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: tabs.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  current = index;
                                });
                              },

                              child: Padding(
                                padding:  EdgeInsets.only(
                                    left: index == 0 ? 10 : 22,
                                    top: 7
                                ),
                                child: Text(tabs[index],
                                  style:GoogleFonts.ubuntu(
                                      fontSize: current == index ? 16 :14,
                                      fontWeight: current == index ? FontWeight.w400 : FontWeight.w300
                                  ) ,),
                              ),
                            );
                          }
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    bottom: 0,
                    left: changeLinePosition(),
                    curve: Curves.fastLinearToSlowEaseIn,
                    duration: Duration(milliseconds: 500),
                    child: AnimatedContainer(
                      curve: Curves.fastLinearToSlowEaseIn,
                      margin: EdgeInsets.only(left: 5),
                      duration: Duration(milliseconds: 500),
                      width: changeLineWidth(),
                      height: size.height * 0.006,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black
                      ),
                    ),
                  ),

                ],
              ),
            ),
            if(tabs[current] == "Local")
              Localforms()
            else if(tabs[current] == "Organisation")
              Organisationform()
            else if(tabs[current] == "Section")
                Sectionform()
              else
                Pledgeform()
            ,

          ],
        ),
      ),
    );
  }
}
