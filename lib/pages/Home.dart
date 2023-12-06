import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:umc_finance/Services/GeneralServices.dart';

import '../Model/api_response.dart';

class Home extends StatefulWidget {
  final GeneralServices generalServices;
  const Home({Key? key, required this.generalServices}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _pageIndexNotifier = ValueNotifier<int>(0);
  late APIResponse _apiResponse = APIResponse();
  late APIResponse financialTargets = APIResponse();
  bool _isLoading = false;

  @override
  void initState() {
    _fetchRecentTransactions();
    super.initState();
  }

  _fetchRecentTransactions() async {
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await widget.generalServices.getRecentTransactions();
    financialTargets = await widget.generalServices.getFinancialTargets();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Builder(
              builder: (_) {
                if (_isLoading) {
                  return FinancialTargetsShimmer();
                }
                if (_apiResponse.error) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${_apiResponse?.errorMessage}'),
                    ),
                  );
                }
              return SizedBox(
                height: 230,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 2, // Number of cards
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.black,
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${financialTargets.data[index].level} Financial Target",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 30),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: financialTargets.data.length,
                                itemBuilder: (context, subIndex) {
                                  if (financialTargets.data[subIndex].level ==
                                      financialTargets.data[index].level) {
                                    return Text(
                                      "${financialTargets.data[subIndex].financeDescription.description} \$${financialTargets.data[subIndex].amount}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    );
                                  } else {
                                    return SizedBox.shrink(); // Empty SizedBox if levels don't match
                                  }
                                },
                              ),
                            ],
                          ),

                        ),
                      ),
                    );
                  },
                  onPageChanged: (index) {
                    _pageIndexNotifier.value = index;
                  },
                ),
              );
            }
          ),
          const SizedBox(height: 20),
          Center(
            child: CirclePageIndicator(
              size: 8.0,
              selectedSize: 10.0,
              dotSpacing: 15.0,
              itemCount: 2,
              currentPageNotifier: _pageIndexNotifier,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Recent Transactions",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Builder(
            builder: (_) {
              if (_isLoading) {
                return RecentsShimmer();
              }
              if (_apiResponse.error) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${_apiResponse?.errorMessage}'),
                  ),
                );
              }
              return Expanded(
                child: ListView.separated(
                  separatorBuilder: (_, __) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(height: 25, color: Colors.black),
                  ),
                  itemBuilder: (_, index) {
                    final recents = _apiResponse.data[index];
                    return ListTile(
                      title: Text("${recents.paymentType} / ${recents.financeDescription}"),
                      subtitle: Text("Amount: \$ ${recents.amount}"),
                    );
                  },
                  itemCount: _apiResponse.data.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class RecentsShimmer extends StatelessWidget {
  const RecentsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Container(
                  width: double.infinity, // Adjust the width based on your design
                  height: 230.0,
                  color: Colors.white,
            ),
          ),
          ),
        );
  }
}

class FinancialTargetsShimmer extends StatelessWidget {
  const FinancialTargetsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.black,
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Section Finance Targets",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "Harvest: \$120",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Building Fund: \$ 2000",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

