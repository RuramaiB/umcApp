import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../Model/api_response.dart';
import '../Services/LocalFinanceService.dart';

class LocalFinanceList extends StatefulWidget {
  @override
  State<LocalFinanceList> createState() => _LocalFinanceListState();
}

class _LocalFinanceListState extends State<LocalFinanceList> {
  //NoteList({Key? key}) : super(key: key);
  LocalFinanceServices get service => GetIt.I<LocalFinanceServices>();

  late APIResponse _apiResponse;
  bool _isLoading = false;

  String formatDateTime(DateTime dateTime){
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
  @override
  void initState() {
    _fetchLocalFinances();
    super.initState();
  }

  _fetchLocalFinances() async{
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await service.getLocalFinanceList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Local Finance',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.amber,
      ),
      body: Builder(
        builder: (_){

          if(_isLoading){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child:CircularProgressIndicator()),
              ],
            );
          }
          if(_apiResponse.error){
            return Center(child: Text('${_apiResponse?.errorMessage}'));
          }

          return ListView.separated(
            separatorBuilder: (_, __) => Divider(height: 1, color: Colors.green),
            itemBuilder: (_, index){
              return ListTile(
                title: Text(
                  _apiResponse.data[index].financeID,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                subtitle: Text(
                    'Payment Done on ${formatDateTime(_apiResponse.data[index].amount)}'),
              );
            },
            itemCount: _apiResponse.data.length,
          );
        } ,
      ),
    );
  }
}

