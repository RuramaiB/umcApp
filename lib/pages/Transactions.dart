import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:umc_finance/Services/OrganisationFinanceService.dart';
import 'package:umc_finance/Services/PledgesServices.dart';
import 'package:umc_finance/Services/SectionFinanceService.dart';
import '../Model/api_response.dart';
import '../Services/LocalFinanceService.dart';
class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  PageController _pageController = PageController(initialPage: 0);
  List<String> tabs = [
    "Local",
    "Section",
    "Organisation",
    "Pledges"
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
          "Transactions",
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
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  current = index;
                });
              },
              children: [
                LocalFinanceList(localFinanceService: GetIt.I<LocalFinanceServices>()),
                SectionFinanceList(sectionFinanceService: GetIt.I<SectionFinanceServices>()),
                OrganisationFinanceList(organisationFinanceServices: GetIt.I<OrganisationFinanceServices>()),
                PledgesList(pledgesFinanceServices: GetIt.I<PledgesFinanceServices>()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LocalFinanceList extends StatefulWidget {
  final LocalFinanceServices localFinanceService;
  const LocalFinanceList({super.key, required this.localFinanceService});

  @override
  State<LocalFinanceList> createState() => _LocalFinanceListState();
}

class _LocalFinanceListState extends State<LocalFinanceList> {
  late APIResponse _apiResponse;
  bool _isLoading = false;
  @override
  void initState() {
    _fetchLocalFinances();
    super.initState();
  }

  _fetchLocalFinances() async{
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await widget.localFinanceService.getLocalFinanceList();

    setState(() {
      _isLoading = false;
    });
  }
  String formatDateTime(DateTime dateTime){
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  DateTime convertToDate(List<int>? dateList) {
    if (dateList == null || dateList.length < 3) {
      return DateTime.now(); // You can return a default value or handle this case differently
    }
    return DateTime(dateList[0], dateList[1], dateList[2]);
  }



  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (_) {
        if (_isLoading) {
          return TransactionsShimmer();
        }
        if (_apiResponse.error) {
          return Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${_apiResponse?.errorMessage}'),
          ));
        }

        return Expanded(
          child: ListView.separated(
            separatorBuilder: (_, __) => Divider(height: 1, color: Colors.green),
            itemBuilder: (_, index) {
              final financeData = _apiResponse.data[index];
              return Card(
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Finance ID: ${financeData.financeID?.toString() ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 17,
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        'Date of Payment: ${formatDateTime(convertToDate(financeData.dateOfPayment)) ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 17,
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                      Text('Payment Description: ${financeData.financeDescription ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 17,
                          // fontWeight: FontWeight.bold
                        ),),
                      Text('Currency: ${financeData.currency ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 17,
                          // fontWeight: FontWeight.bold
                        ),),
                      Text('Payment Method: ${financeData.paymentMethod ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 17,
                          // fontWeight: FontWeight.bold
                        ),),
                      Text('Amount: ${financeData.amount ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 17,
                          // fontWeight: FontWeight.bold
                        ),),
                    ],
                  ),
                ),
              );

            },
            itemCount: _apiResponse.data.length,
          ),
        );
      },
    );
  }
}

class SectionFinanceList extends StatefulWidget {
  final SectionFinanceServices sectionFinanceService;
  const SectionFinanceList({super.key, required this.sectionFinanceService});

  @override
  State<SectionFinanceList> createState() => _SectionFinanceListState();
}

class _SectionFinanceListState extends State<SectionFinanceList> {
  late APIResponse sectionResponse;
  bool _isLoading = false;

  String formatDateTime(DateTime dateTime){
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  DateTime convertToDate(List<int>? dateList) {
    if (dateList == null || dateList.length < 3) {
      return DateTime.now(); // You can return a default value or handle this case differently
    }
    return DateTime(dateList[0], dateList[1], dateList[2]);
  }

  @override
  void initState() {
    _fetchSectionFinances();
    super.initState();
  }

  _fetchSectionFinances() async{
    setState(() {
      _isLoading = true;
    });
    sectionResponse = await widget.sectionFinanceService.getSectionFinanceList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (_) {
        if (_isLoading) {
          return TransactionsShimmer();
        }
        if (sectionResponse.error) {
          return Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${sectionResponse?.errorMessage}'),
          ));
        }

        return Expanded(
          child: ListView.separated(
            separatorBuilder: (_, __) => Padding(
              padding: const EdgeInsets.all(15.0),
              child: Divider(height: 5, color: Colors.black),
            ),
            itemBuilder: (_, index) {
              final sectionFinanceData = sectionResponse.data[index];
              return Card(
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Finance ID: ${sectionFinanceData.financeID?.toString() ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 17,
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        'Date of Payment: ${formatDateTime(convertToDate(sectionFinanceData.dateOfPayment)) ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 17,
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                      Text('Payment Description: ${sectionFinanceData.financeDescription ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 17,
                          // fontWeight: FontWeight.bold
                        ),),
                      Text('Currency: ${sectionFinanceData.currency ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 17,
                          // fontWeight: FontWeight.bold
                        ),),
                      Text('Payment Method: ${sectionFinanceData.paymentMethod ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 17,
                          // fontWeight: FontWeight.bold
                        ),),
                      Text('Amount: ${sectionFinanceData.amount ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 17,
                          // fontWeight: FontWeight.bold
                        ),),
                    ],
                  ),
                ),
              );

            },
            itemCount: sectionResponse.data.length,
          ),
        );
      },
    );
  }
}

class OrganisationFinanceList extends StatefulWidget {
  final OrganisationFinanceServices organisationFinanceServices;
  const OrganisationFinanceList({super.key, required this.organisationFinanceServices});

  @override
  State<OrganisationFinanceList> createState() => _OrganisationFinanceListState();
}

class _OrganisationFinanceListState extends State<OrganisationFinanceList> {

  late APIResponse orgResponse;
  bool _isLoading = false;

  String formatDateTime(DateTime dateTime){
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  DateTime convertToDate(List<int>? dateList) {
    if (dateList == null || dateList.length < 3) {
      return DateTime.now(); // You can return a default value or handle this case differently
    }
    return DateTime(dateList[0], dateList[1], dateList[2]);
  }

  @override
  void initState() {
    _fetchOrganisationFinances();
    super.initState();
  }

  _fetchOrganisationFinances() async{
    setState(() {
      _isLoading = true;
    });
    orgResponse = await widget.organisationFinanceServices.getOrganisationFinanceList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (_) {
        if (_isLoading) {
          return TransactionsShimmer();
        }
        if (orgResponse.error) {
          return Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${orgResponse?.errorMessage}'),
          ));
        }

        return Expanded(
          child: ListView.separated(
            separatorBuilder: (_, __) => Divider(height: 1, color: Colors.green),
            itemBuilder: (_, index) {
              final sectionFinanceData = orgResponse.data[index];
              return Card(
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Finance ID: ${sectionFinanceData.financeID?.toString() ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 17,
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        'Date of Payment: ${formatDateTime(convertToDate(sectionFinanceData.dateOfPayment)) ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 17,
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                      Text('Payment Description: ${sectionFinanceData.financeDescription ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 17,
                          // fontWeight: FontWeight.bold
                        ),),
                      Text('Currency: ${sectionFinanceData.currency ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 17,
                          // fontWeight: FontWeight.bold
                        ),),
                      Text('Payment Method: ${sectionFinanceData.paymentMethod ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 17,
                          // fontWeight: FontWeight.bold
                        ),),
                      Text('Amount: ${sectionFinanceData.amount ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 17,
                          // fontWeight: FontWeight.bold
                        ),),
                    ],
                  ),
                ),
              );

            },
            itemCount: orgResponse.data.length,
          ),
        );
      },
    );
  }
}

class PledgesList extends StatefulWidget {
  final PledgesFinanceServices pledgesFinanceServices;
  const PledgesList({super.key, required this.pledgesFinanceServices});

  @override
  State<PledgesList> createState() => _PledgesListState();
}

class _PledgesListState extends State<PledgesList> {

  late APIResponse pledgesResponse;
  bool _isLoading = false;

  String formatDateTime(DateTime dateTime){
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  DateTime convertToDate(List<int>? dateList) {
    if (dateList == null || dateList.length < 3) {
      return DateTime.now(); // You can return a default value or handle this case differently
    }
    return DateTime(dateList[0], dateList[1], dateList[2]);
  }

  @override
  void initState() {
    _fetchPledges();
    super.initState();
  }

  _fetchPledges() async{
    setState(() {
      _isLoading = true;
    });
    pledgesResponse = await widget.pledgesFinanceServices.getPledgesList();

    setState(() {
      _isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (_) {
        if (_isLoading) {
          return TransactionsShimmer();
        }
        if (pledgesResponse.error) {
          return Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${pledgesResponse?.errorMessage}'),
          ));
        }

        return Expanded(
          child: ListView.separated(
            separatorBuilder: (_, __) => Divider(height: 1, color: Colors.green),
            itemBuilder: (_, index) {
              final sectionFinanceData = pledgesResponse.data[index];
              return Card(
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Finance ID: ${sectionFinanceData.financeID?.toString() ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 17,
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        'Date of Payment: ${formatDateTime(convertToDate(sectionFinanceData.dateOfPayment)) ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 17,
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                      Text('Payment Description: ${sectionFinanceData.description ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 17,
                          // fontWeight: FontWeight.bold
                        ),),
                      Text('Currency: ${sectionFinanceData.currency ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 17,
                          // fontWeight: FontWeight.bold
                        ),),
                      Text('Payment Method: ${sectionFinanceData.paymentMethod ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 17,
                          // fontWeight: FontWeight.bold
                        ),),
                      Text('Amount: ${sectionFinanceData.amount ?? 'N/A'}',
                        style: TextStyle(
                          fontSize: 17,
                          // fontWeight: FontWeight.bold
                        ),),
                    ],
                  ),
                ),
              );

            },
            itemCount: pledgesResponse.data.length,
          ),
        );
      },
    );
  }
}

class TransactionsShimmer extends StatelessWidget {
  const TransactionsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3, // Number of shimmer cards
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                contentPadding:
                EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100.0, // Adjust the width based on your design
                      height: 100.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      width: 200.0, // Adjust the width based on your design
                      height: 15.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      width: 200.0, // Adjust the width based on your design
                      height: 15.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}



