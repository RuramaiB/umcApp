import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../Model/api_response.dart';
import '../Services/UsersService.dart';

class Profile extends StatefulWidget {
  final UsersService usersService;
  const Profile({super.key, required this.usersService});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late APIResponse _apiResponse;
  bool _isLoading = false;
  @override
  void initState() {
    _fetchProfile();
    super.initState();
  }

  _fetchProfile() async{
    setState(() {
      _isLoading = true;
    });
    _apiResponse = await widget.usersService.getUser();

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
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
        backgroundColor: Colors.black,
      ),
      body: Builder(
        builder: (_) {
          if (_isLoading) {
            return UserDetailsShimmer();
          }
          if (_apiResponse.error) {
            return Center(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${_apiResponse?.errorMessage}'),
            ));
          }
          final profileInfo = _apiResponse.data;
          return Card(
            elevation: 5,
            margin: EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'User Details',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.0),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('First Name'),
                    subtitle: Text('${profileInfo.firstname}'),
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Last Name'),
                    subtitle: Text('${profileInfo.lastname}'),
                  ),
                  ListTile(
                    title: Text('Gender'),
                    subtitle: Text('${profileInfo.gender}'),
                    leading: profileInfo.gender.toLowerCase() == 'male'
                        ? Icon(Icons.male)
                        : profileInfo.gender.toLowerCase() == 'female'
                        ? Icon(Icons.female)
                        : Icon(Icons.person),
                  ),

                  ListTile(
                    leading: Icon(Icons.date_range),
                    title: Text('Date Of Birth'),
                    subtitle: Text('${formatDateTime(convertToDate(profileInfo.dateOfBirth)) ?? 'N/A'}'),
                  ),
                  ListTile(
                    leading: Icon(Icons.church),
                    title: Text('Local'),
                    subtitle: Text('${profileInfo.locals.name}'),
                  ),
                  ListTile(
                    leading: Icon(Icons.group),
                    title: Text('Section'),
                    subtitle: Text('${profileInfo.section.name}'),
                  ),
                  ListTile(
                    leading: Icon(Icons.web),
                    title: Text('Organisation'),
                    subtitle: Text('${profileInfo.organisation}'),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}

class UserDetailsShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'User Details',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('First Name'),
                subtitle: Text('Ruramai'),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Last Name'),
                subtitle: Text('Botso'),
              ),
              ListTile(
                leading: Icon(Icons.transgender),
                title: Text('Gender'),
                subtitle: Text('Male'),
              ),
              ListTile(
                leading: Icon(Icons.date_range),
                title: Text('Date Of Birth'),
                subtitle: Text('10/08/11'),
              ),
              ListTile(
                leading: Icon(Icons.church),
                title: Text('Local'),
                subtitle: Text('St Andrews'),
              ),
              ListTile(
                leading: Icon(Icons.group),
                title: Text('Section'),
                subtitle: Text('P2'),
              ),
              ListTile(
                leading: Icon(Icons.web),
                title: Text('Organisation'),
                subtitle: Text('UMYF'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
