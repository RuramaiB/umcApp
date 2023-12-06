import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umc_finance/Model/FinanceDescription.dart';
import 'package:umc_finance/Model/LocalFinances.dart';
import 'package:umc_finance/Model/OrganisationFinances.dart';
import 'package:umc_finance/Model/Pledges.dart';
import 'package:umc_finance/Model/SectionFinances.dart';
import 'package:umc_finance/Services/GeneralServices.dart';
import 'package:umc_finance/Services/LocalFinanceService.dart';
import 'package:umc_finance/Services/OrganisationFinanceService.dart';
import 'package:umc_finance/Services/PledgesServices.dart';
import 'package:umc_finance/Services/SectionFinanceService.dart';

import '../Model/api_response.dart';

class Payments extends StatefulWidget {
  const Payments({super.key});

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  PageController _pageController = PageController(initialPage: 0);
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
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Payments",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: Column(
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
                          return Padding(
                            padding:  EdgeInsets.only(
                                left: index == 0 ? 10 : 22,
                                top: 7
                            ),
                            child: Text(tabs[index],
                              style:GoogleFonts.ubuntu(
                                  fontSize: current == index ? 16 :14,
                                  fontWeight: current == index ? FontWeight.w400 : FontWeight.w300
                              ) ,),
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
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  current = index;
                });
              },
              children: [
                LocalForm(generalServices: GetIt.I<GeneralServices>()),
                SectionForm(generalServices: GetIt.I<GeneralServices>()),
                OrganisationForm(generalServices: GetIt.I<GeneralServices>()),
                PledgeForm(generalServices: GetIt.I<GeneralServices>()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Define your form widgets outside the build method for improved readability
class LocalForm extends StatefulWidget {
  final GeneralServices generalServices;
  const LocalForm({super.key, required this.generalServices});
  @override
  State<LocalForm> createState() => _LocalFormState();
}

class _LocalFormState extends State<LocalForm> {
  late List<DropDownValueModel> financeDescriptions;
  @override
  late APIResponse fdResponse = APIResponse(data: null, error: false);
  late APIResponse  pmResponse = APIResponse(data: null, error: false);
  bool _isLoading = false;
  @override
  void initState() {
    _fetchPaymentData();
    financeDescriptions = _extractFinanceDescriptions();
    super.initState();
  }

  _fetchPaymentData() async{
    setState(() {
      _isLoading = true;
    });
    fdResponse = await widget.generalServices.getFinanceDescriptions();
    pmResponse = await widget.generalServices.getPaymentMethods();
    setState(() {
      _isLoading = false;
    });
  }


  List<DropDownValueModel> _extractFinanceDescriptions() {
    if (fdResponse.error || fdResponse.data == null) {
      return [];
    }
    return (fdResponse.data as List<dynamic>).map((description) {
      return DropDownValueModel(
        name: description.description,
        value: description.description,
      );
    }).toList();
  }
  List<DropDownValueModel> _extractPaymentMethods() {
    if (pmResponse.error || pmResponse.data == null) {
      return [];
    }
    return (pmResponse.data as List<dynamic>).map((method) {
      return DropDownValueModel(
        name: method.paymentMethod,   // Assuming 'name' is a property in FinanceDescription
        value: method.paymentMethod, // Assuming 'value' is a property in FinanceDescription
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
     SingleValueDropDownController financeDesc = SingleValueDropDownController();
     SingleValueDropDownController paymentMeth  = SingleValueDropDownController();
     SingleValueDropDownController currency  = SingleValueDropDownController();
    TextEditingController amount = TextEditingController();
     TextEditingController phoneNumber = TextEditingController();
    LocalFinanceServices localFinanceServices = LocalFinanceServices();
    Widget _buildDescription() {
      List<DropDownValueModel> financeDescriptions = _extractFinanceDescriptions();

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
          ],
        ),
        child: DropDownTextField(
          clearOption: false,
          controller: financeDesc ,
          dropDownItemCount: financeDescriptions.length, // Use the length of the dynamic list
          textFieldDecoration: const InputDecoration(
            labelText: "  Select payment description",
            contentPadding: EdgeInsets.symmetric(horizontal: 25),
            border: InputBorder.none,
          ),
          dropDownList: financeDescriptions, // Use the dynamically generated list
          onChanged: (val) {
           val = financeDescriptions;
          },
        ),
      );
    }
    Widget _buildPaymentMethod(){
      List<DropDownValueModel> paymentMethods = _extractPaymentMethods();
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
          ],
        ),
        child: DropDownTextField(
          clearOption: false,
          controller: paymentMeth,
          dropDownItemCount: paymentMethods.length, // Use the length of the dynamic list
          textFieldDecoration: InputDecoration(
            labelText: "  Select payment method",
            contentPadding: EdgeInsets.symmetric(horizontal: 25),
            border: InputBorder.none,
          ),
          dropDownList: paymentMethods, // Use the dynamically generated list
          onChanged: (val) {
            val = paymentMethods;
          },
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
        child:DropDownTextField(
          clearOption: false,
          dropDownItemCount: 2,
          controller: currency,
          textFieldDecoration: InputDecoration(
            labelText: "Select currency",
            contentPadding: EdgeInsets.symmetric(horizontal: 25),
            border: InputBorder.none,
          ),
          dropDownList: const [
            DropDownValueModel(name: 'ZWL', value: "ZWL"),
            DropDownValueModel(
                name: 'USD',
                value: "USD"),
          ],
          onChanged: (val) {},
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
          controller: amount,
          decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14, left: 25, bottom: 10),
              hintText: "Enter your amount"
          ),
        ),
      );
    }
     Widget _buildPhoneNumber(){
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
           controller: phoneNumber,
           decoration: const InputDecoration(
               border: InputBorder.none,
               contentPadding: EdgeInsets.only(top: 14, left: 25, bottom: 10),
               hintText: "Enter your phone number"
           ),
         ),
       );
     }
    return SingleChildScrollView(
      child:  Padding(
        padding: const EdgeInsets.symmetric(vertical: 40,),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Make a local finance payment now.",
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
              child: _buildPhoneNumber(),
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
              onPressed: _isLoading
                  ? null // Disable the button when loading
                  : () async {
                final SharedPreferences prefs = await SharedPreferences.getInstance();
                Object? pp = prefs.get('local');
                Object? mN = prefs.get('membershipNumber');
                LocalFinances localFinances = LocalFinances(
                  amount: double.tryParse(amount.text),
                  paymentMethod: paymentMeth.dropDownValue!.value,
                  membershipNumber: "$mN",
                  phoneNumber: phoneNumber.text,
                  financeDescription: financeDesc.dropDownValue!.value,
                  currency: currency.dropDownValue!.value,
                  locals: "$pp",
                );
                setState(() {
                  _isLoading = true;
                });
                final result = await localFinanceServices.localFinancePayment(localFinances);
                setState(() {
                  _isLoading = false;
                });
                print(result);
              },
              child: _isLoading
                  ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
                  : const Padding(
                padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                child: Text(
                  "Submit",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: Colors.white,
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
}

class SectionForm extends StatefulWidget {
  final GeneralServices generalServices;
  const SectionForm({super.key, required this.generalServices});

  @override
  State<SectionForm> createState() => _SectionFormState();
}

class _SectionFormState extends State<SectionForm> {
  late List<DropDownValueModel> financeDescriptions;
  @override
  late APIResponse fdResponse = APIResponse(data: null, error: false);
  late APIResponse  pmResponse = APIResponse(data: null, error: false);
  bool _isLoading = false;
  @override
  void initState() {
    _fetchPaymentData();
    financeDescriptions = _extractFinanceDescriptions();
    super.initState();
  }

  _fetchPaymentData() async{
    setState(() {
      _isLoading = true;
    });
    fdResponse = await widget.generalServices.getFinanceDescriptions();
    pmResponse = await widget.generalServices.getPaymentMethods();
    setState(() {
      _isLoading = false;
    });
  }


  List<DropDownValueModel> _extractFinanceDescriptions() {
    if (fdResponse.error || fdResponse.data == null) {
      return [];
    }
    return (fdResponse.data as List<dynamic>).map((description) {
      return DropDownValueModel(
        name: description.description,
        value: description.description,
      );
    }).toList();
  }
  List<DropDownValueModel> _extractPaymentMethods() {
    if (pmResponse.error || pmResponse.data == null) {
      return [];
    }
    return (pmResponse.data as List<dynamic>).map((method) {
      return DropDownValueModel(
        name: method.paymentMethod,   // Assuming 'name' is a property in FinanceDescription
        value: method.paymentMethod, // Assuming 'value' is a property in FinanceDescription
      );
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
    SingleValueDropDownController financeDesc = SingleValueDropDownController();
    SingleValueDropDownController paymentMeth  = SingleValueDropDownController();
    SingleValueDropDownController currency  = SingleValueDropDownController();
    TextEditingController amount = TextEditingController();
    TextEditingController phoneNumber = TextEditingController();
    TextEditingController section = TextEditingController();
    SectionFinanceServices sectionFinanceServices = SectionFinanceServices();
    Widget _buildDescription() {
      List<DropDownValueModel> financeDescriptions = _extractFinanceDescriptions();

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
          ],
        ),
        child: DropDownTextField(
          clearOption: false,
          controller: financeDesc ,
          dropDownItemCount: financeDescriptions.length, // Use the length of the dynamic list
          textFieldDecoration: const InputDecoration(
            labelText: "  Select payment description",
            contentPadding: EdgeInsets.symmetric(horizontal: 25),
            border: InputBorder.none,
          ),
          dropDownList: financeDescriptions, // Use the dynamically generated list
          onChanged: (val) {
            val = financeDescriptions;
          },
        ),
      );
    }
    Widget _buildPaymentMethod(){
      List<DropDownValueModel> paymentMethods = _extractPaymentMethods();
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
          ],
        ),
        child: DropDownTextField(
          clearOption: false,
          controller: paymentMeth,
          dropDownItemCount: paymentMethods.length, // Use the length of the dynamic list
          textFieldDecoration: InputDecoration(
            labelText: "  Select payment method",
            contentPadding: EdgeInsets.symmetric(horizontal: 25),
            border: InputBorder.none,
          ),
          dropDownList: paymentMethods, // Use the dynamically generated list
          onChanged: (val) {
            val = paymentMethods;
          },
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
        child:DropDownTextField(
          clearOption: false,
          dropDownItemCount: 2,
          controller: currency,
          textFieldDecoration: InputDecoration(
            labelText: "Select currency",
            contentPadding: EdgeInsets.symmetric(horizontal: 25),
            border: InputBorder.none,
          ),
          dropDownList: const [
            DropDownValueModel(name: 'ZWL', value: "ZWL"),
            DropDownValueModel(
                name: 'USD',
                value: "USD"),
          ],
          onChanged: (val) {},
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
          controller: amount,
          decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14, left: 25, bottom: 10),
              hintText: "Enter your amount"
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
        child:
        TextFormField(

          validator: (value){
            if(value == null || value.isEmpty){
              return "Enter your amount";
            }
          },
          controller: section,
          decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14, left: 25, bottom: 10),
          ),
        ),
      );
    }
    Widget _buildPhoneNumber(){
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
              return "Enter your phone number.";
            }
          },
          controller: phoneNumber,
          decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14, left: 25, bottom: 10),
              hintText: "Enter your phone number"
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child:  Padding(
        padding: const EdgeInsets.symmetric(vertical: 40,),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Make a section payment now.",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                ),
              ),
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
              child: _buildPhoneNumber(),
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
              onPressed: _isLoading
                  ? null // Disable the button when loading
                  : () async {
                final SharedPreferences prefs = await SharedPreferences.getInstance();
                Object? pp = prefs.get('local');
                Object? mN = prefs.get('membershipNumber');
                SectionFinances sectionFinances = SectionFinances(
                    financeDescription: financeDesc.dropDownValue!.value,
                    amount: double.tryParse(amount.text),
                    currency: currency.dropDownValue!.value,
                    paymentMethod: paymentMeth.dropDownValue!.value,
                    membershipNumber: "$mN",
                    phoneNumber: phoneNumber.text,
                    locals: '$pp'
                );
                setState(() {
                  _isLoading = true;
                });
                final result = await sectionFinanceServices.sectionFinancePayment(sectionFinances);
                setState(() {
                  _isLoading = false;
                });
                print(result);
              },
              child: _isLoading
                  ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
                  : const Padding(
                padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                child: Text(
                  "Submit",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: Colors.white,
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
}

class OrganisationForm extends StatefulWidget {
  final GeneralServices generalServices;
  const OrganisationForm({super.key, required this.generalServices});

  @override
  State<OrganisationForm> createState() => _OrganisationFormState();
}

class _OrganisationFormState extends State<OrganisationForm> {
  late List<DropDownValueModel> financeDescriptions;
  @override
  late APIResponse fdResponse = APIResponse(data: null, error: false);
  late APIResponse  pmResponse = APIResponse(data: null, error: false);
  bool _isLoading = false;
  @override
  void initState() {
    _fetchPaymentData();
    financeDescriptions = _extractFinanceDescriptions();
    super.initState();
  }

  _fetchPaymentData() async{
    setState(() {
      _isLoading = true;
    });
    fdResponse = await widget.generalServices.getFinanceDescriptions();
    pmResponse = await widget.generalServices.getPaymentMethods();
    setState(() {
      _isLoading = false;
    });
  }


  List<DropDownValueModel> _extractFinanceDescriptions() {
    if (fdResponse.error || fdResponse.data == null) {
      return [];
    }
    return (fdResponse.data as List<dynamic>).map((description) {
      return DropDownValueModel(
        name: description.description,
        value: description.description,
      );
    }).toList();
  }
  List<DropDownValueModel> _extractPaymentMethods() {
    if (pmResponse.error || pmResponse.data == null) {
      return [];
    }
    return (pmResponse.data as List<dynamic>).map((method) {
      return DropDownValueModel(
        name: method.paymentMethod,   // Assuming 'name' is a property in FinanceDescription
        value: method.paymentMethod, // Assuming 'value' is a property in FinanceDescription
      );
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
    SingleValueDropDownController financeDesc = SingleValueDropDownController();
    SingleValueDropDownController paymentMeth  = SingleValueDropDownController();
    SingleValueDropDownController currency  = SingleValueDropDownController();
    TextEditingController amount = TextEditingController();
    TextEditingController phoneNumber = TextEditingController();
    OrganisationFinanceServices organisationFinanceServices = OrganisationFinanceServices();
    Widget _buildDescription() {
      List<DropDownValueModel> financeDescriptions = _extractFinanceDescriptions();

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
          ],
        ),
        child: DropDownTextField(
          clearOption: false,
          controller: financeDesc ,
          dropDownItemCount: financeDescriptions.length, // Use the length of the dynamic list
          textFieldDecoration: const InputDecoration(
            labelText: "  Select payment description",
            contentPadding: EdgeInsets.symmetric(horizontal: 25),
            border: InputBorder.none,
          ),
          dropDownList: financeDescriptions, // Use the dynamically generated list
          onChanged: (val) {
            val = financeDescriptions;
          },
        ),
      );
    }
    Widget _buildPaymentMethod(){
      List<DropDownValueModel> paymentMethods = _extractPaymentMethods();
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
          ],
        ),
        child: DropDownTextField(
          clearOption: false,
          controller: paymentMeth,
          dropDownItemCount: paymentMethods.length, // Use the length of the dynamic list
          textFieldDecoration: InputDecoration(
            labelText: "  Select payment method",
            contentPadding: EdgeInsets.symmetric(horizontal: 25),
            border: InputBorder.none,
          ),
          dropDownList: paymentMethods, // Use the dynamically generated list
          onChanged: (val) {
            val = paymentMethods;
          },
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
        child:DropDownTextField(
          clearOption: false,
          dropDownItemCount: 2,
          controller: currency,
          textFieldDecoration: InputDecoration(
            labelText: "Select currency",
            contentPadding: EdgeInsets.symmetric(horizontal: 25),
            border: InputBorder.none,
          ),
          dropDownList: const [
            DropDownValueModel(name: 'ZWL', value: "ZWL"),
            DropDownValueModel(
                name: 'USD',
                value: "USD"),
          ],
          onChanged: (val) {},
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
          controller: amount,
          decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14, left: 25, bottom: 10),
              hintText: "Enter your amount"
          ),
        ),
      );
    }
    Widget _buildPhoneNumber(){
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
          controller: phoneNumber,
          decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14, left: 25, bottom: 10),
              hintText: "Enter your phone number"
          ),
        ),
      );
    }
    return SingleChildScrollView(
      child:  Padding(
        padding: const EdgeInsets.symmetric(vertical: 40,),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Make a organisation payment now.",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                ),
              ),
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
              child: _buildPhoneNumber(),
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
              onPressed: _isLoading
                  ? null // Disable the button when loading
                  : () async {
                final SharedPreferences prefs = await SharedPreferences.getInstance();
                Object? pp = prefs.get('local');
                Object? mN = prefs.get('membershipNumber');
                OrganisationFinance organisationFinances = OrganisationFinance(
                  amount: double.tryParse(amount.text),
                  paymentMethod: paymentMeth.dropDownValue!.value,
                  membershipNumber: "$mN",
                  phoneNumber: phoneNumber.text,
                  financeDescription: financeDesc.dropDownValue!.value,
                  currency: currency.dropDownValue!.value,
                  locals: "$pp",
                );
                setState(() {
                  _isLoading = true;
                });
                final result = await organisationFinanceServices.organisationFinancePayment(organisationFinances);
                setState(() {
                  _isLoading = false;
                });
                print(result);
              },
              child: _isLoading
                  ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
                  : const Padding(
                padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                child: Text(
                  "Submit",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: Colors.white,
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
}

class PledgeForm extends StatefulWidget {
  final GeneralServices generalServices;
  const PledgeForm({super.key, required this.generalServices});

  @override
  State<PledgeForm> createState() => _PledgeFormState();
}

class _PledgeFormState extends State<PledgeForm> {
  late List<DropDownValueModel> financeDescriptions;
  @override
  late APIResponse fdResponse = APIResponse(data: null, error: false);
  late APIResponse  pmResponse = APIResponse(data: null, error: false);
  bool _isLoading = false;
  @override
  void initState() {
    _fetchPaymentData();
    financeDescriptions = _extractFinanceDescriptions();
    super.initState();
  }

  _fetchPaymentData() async{
    setState(() {
      _isLoading = true;
    });
    fdResponse = await widget.generalServices.getFinanceDescriptions();
    pmResponse = await widget.generalServices.getPaymentMethods();
    setState(() {
      _isLoading = false;
    });
  }


  List<DropDownValueModel> _extractFinanceDescriptions() {
    if (fdResponse.error || fdResponse.data == null) {
      return [];
    }
    return (fdResponse.data as List<dynamic>).map((description) {
      return DropDownValueModel(
        name: description.description,
        value: description.description,
      );
    }).toList();
  }
  List<DropDownValueModel> _extractPaymentMethods() {
    if (pmResponse.error || pmResponse.data == null) {
      return [];
    }
    return (pmResponse.data as List<dynamic>).map((method) {
      return DropDownValueModel(
        name: method.paymentMethod,   // Assuming 'name' is a property in FinanceDescription
        value: method.paymentMethod, // Assuming 'value' is a property in FinanceDescription
      );
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
    SingleValueDropDownController financeDesc = SingleValueDropDownController();
    SingleValueDropDownController paymentMeth  = SingleValueDropDownController();
    SingleValueDropDownController currency  = SingleValueDropDownController();
    TextEditingController amount = TextEditingController();
    TextEditingController phoneNumber = TextEditingController();
    PledgesFinanceServices pledgesFinanceServices = PledgesFinanceServices();
    Widget _buildDescription() {
      List<DropDownValueModel> financeDescriptions = _extractFinanceDescriptions();

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
          ],
        ),
        child: DropDownTextField(
          clearOption: false,
          controller: financeDesc ,
          dropDownItemCount: financeDescriptions.length, // Use the length of the dynamic list
          textFieldDecoration: const InputDecoration(
            labelText: "  Select payment description",
            contentPadding: EdgeInsets.symmetric(horizontal: 25),
            border: InputBorder.none,
          ),
          dropDownList: financeDescriptions, // Use the dynamically generated list
          onChanged: (val) {
            val = financeDescriptions;
          },
        ),
      );
    }
    Widget _buildPaymentMethod(){
      List<DropDownValueModel> paymentMethods = _extractPaymentMethods();
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
          ],
        ),
        child: DropDownTextField(
          clearOption: false,
          controller: paymentMeth,
          dropDownItemCount: paymentMethods.length, // Use the length of the dynamic list
          textFieldDecoration: InputDecoration(
            labelText: "  Select payment method",
            contentPadding: EdgeInsets.symmetric(horizontal: 25),
            border: InputBorder.none,
          ),
          dropDownList: paymentMethods, // Use the dynamically generated list
          onChanged: (val) {
            val = paymentMethods;
          },
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
        child:DropDownTextField(
          clearOption: false,
          dropDownItemCount: 2,
          controller: currency,
          textFieldDecoration: InputDecoration(
            labelText: "Select currency",
            contentPadding: EdgeInsets.symmetric(horizontal: 25),
            border: InputBorder.none,
          ),
          dropDownList: const [
            DropDownValueModel(name: 'ZWL', value: "ZWL"),
            DropDownValueModel(
                name: 'USD',
                value: "USD"),
          ],
          onChanged: (val) {},
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
          controller: amount,
          decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14, left: 25, bottom: 10),
              hintText: "Enter your amount"
          ),
        ),
      );
    }
    Widget _buildPhoneNumber(){
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
          controller: phoneNumber,
          decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14, left: 25, bottom: 10),
              hintText: "Enter your phone number"
          ),
        ),
      );
    }
    return SingleChildScrollView(
      child:  Padding(
        padding: const EdgeInsets.symmetric(vertical: 40,),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Make a pledge now.",
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
              child: _buildPhoneNumber(),
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
              onPressed: _isLoading
                  ? null // Disable the button when loading
                  : () async {
                final SharedPreferences prefs = await SharedPreferences.getInstance();
                Object? pp = prefs.get('local');
                Object? mN = prefs.get('membershipNumber');
                Pledges pledges = Pledges(
                  amount: double.tryParse(amount.text),
                  paymentMethod: paymentMeth.dropDownValue!.value,
                  membershipNumber: "$mN",
                  phoneNumber: phoneNumber.text,
                  financeDescription: financeDesc.dropDownValue!.value,
                  currency: currency.dropDownValue!.value,
                  locals: "$pp",
                );
                setState(() {
                  _isLoading = true;
                });
                final result = await pledgesFinanceServices.pledgesPayment(pledges);
                setState(() {
                  _isLoading = false;
                });
                print(result);
              },
              child: _isLoading
                  ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
                  : const Padding(
                padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                child: Text(
                  "Submit",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: Colors.white,
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
}


