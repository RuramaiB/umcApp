import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umc_finance/Model/Users.dart';

import '../Model/api_response.dart';
import '../Services/UsersService.dart';
import 'Home.dart';

class EditProfile extends StatefulWidget {
  final UsersService usersService;
  const EditProfile({super.key, required this.usersService});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  UsersService usersService = UsersService();
  late APIResponse _apiResponse = APIResponse();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Builder(
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
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: _firstNameController,
                          decoration: InputDecoration(
                            labelText: 'First Name',
                              hintText: '${_apiResponse.data?.firstname}', // Placeholder text
                          ),
                        ),
                        TextFormField(
                          controller: _lastNameController,
                          decoration: InputDecoration(
                              labelText: 'Last Name',
                            hintText: '${_apiResponse.data?.lastname}',
                          ),
                        ),
                        TextFormField(
                          controller: _genderController,
                          decoration: InputDecoration(
                              labelText: 'Gender',
                            hintText: '${_apiResponse.data?.gender}',
                          ),
                        ),
                        TextFormField(
                          controller: _dateOfBirthController,
                          decoration: InputDecoration(
                              labelText: 'Date of Birth',
                            hintText: '${_apiResponse.data?.dateOfBirth}',
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith((states) => Colors.black)
                          ),
                          onPressed: _isLoading
                                ? null // Disable the button when loading
                              : () async {
                            final SharedPreferences prefs = await SharedPreferences.getInstance();
                            Object? pp = prefs.get('local');
                            Object? mN = prefs.get('membershipNumber');
                            Users users = Users(
                                firstname: _firstNameController.text,
                                lastname: _lastNameController.text,
                                gender: _genderController.text,
                                // dateOfBirth: dateOfBirth,
                                // phoneNumber: phoneNumber,
                                membershipNumber: "$mN",
                            );
                            setState(() {
                              _isLoading = true;
                            });
                            final result = await usersService.updateProfile(users);
                            setState(() {
                              _isLoading = false;
                            });
                            print(result);
                          },
                          child: Text(
                                "Update Profile",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                      ],
                    );
                  }
                ),
              ),
            ),
          ),
        ));
  }
}
