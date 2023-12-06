import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:share/share.dart';
import 'package:shimmer/shimmer.dart';
import 'package:umc_finance/Services/UsersService.dart';
import 'package:umc_finance/pages/EditProfile.dart';
import 'package:umc_finance/pages/aboutApp.dart';
import 'package:umc_finance/pages/helpCenter.dart';
import 'package:umc_finance/pages/signIn.dart';

import '../Model/api_response.dart';
import 'Profile.dart';

class Settings extends StatefulWidget {
  final UsersService usersService;
  const Settings({super.key, required this.usersService});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _iconBool = false;
  IconData _iconLight = Icons.wb_sunny;
  IconData _iconDark = Icons.nights_stay;
  ThemeData _lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light
  );
  ThemeData _darkTheme = ThemeData(
    primarySwatch: Colors.red,
    brightness: Brightness.dark
  );
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
  Future<void> _showShareOptions(BuildContext context) async {
    Share.share(
      'Check out the new UMC Finance application on play store.',
      subject: 'Share',
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _iconBool ? _darkTheme : _lightTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
      backgroundColor: Colors.black,
      automaticallyImplyLeading: false,
          actions: [
            IconButton(onPressed: (){
              setState(() {
                _iconBool = !_iconBool;
              });
            },
                icon: Icon(_iconBool ? _iconDark : _iconLight))
          ],
      ),
        body:  SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> Profile(usersService: GetIt.I<UsersService>())));
                    },
                    style: ButtonStyle(
                        padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.all(20)),
                        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white)

                    ),

                    child: Row(
                      children: [

                        Builder(
                          builder: (context) {
                             if (_isLoading) {
                                return const ProfileShimmer();
                              }
                              if (_apiResponse.error) {
                                return Center(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('${_apiResponse?.errorMessage}'),
                                ));
                              }
                              final profileInfo = _apiResponse.data;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${profileInfo.lastname}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        color: Colors.black
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "${profileInfo.firstname}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: Colors.black
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${profileInfo.membershipNumber}",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            );
                          }
                        )

                      ],
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: MaterialButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>  EditProfile(usersService: GetIt.I<UsersService>())));
                    },
                    padding: EdgeInsets.all(20),
                    color: Color(0xFFF5F6F9),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        SizedBox(width: 20),
                        Expanded(child: Text(
                          "Edit profile",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold
                          ) ,)),
                        Icon(Icons.arrow_forward_ios,color: Colors.grey,)
                      ],
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> const  AboutApp()));
                    },
                    style: ButtonStyle(
                        padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.all(20)),
                        backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xFFF5F6F9))

                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.black,
                        ),
                        SizedBox(width: 20),
                        Expanded(child: Text(
                          "About App",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.bold
                          ) ,)),
                        Icon(Icons.arrow_forward_ios,color: Colors.grey,)
                      ],
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_)=> const  HelpCenter()));
                    },
                    style: ButtonStyle(
                        padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.all(20)),
                        backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xFFF5F6F9))

                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.help,
                          color: Colors.black,
                        ),
                        SizedBox(width: 20),
                        Expanded(child: Text(
                          "Help Center",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.bold
                          ) ,)),
                        Icon(Icons.arrow_forward_ios,color: Colors.grey,)
                      ],
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ElevatedButton(
                  onPressed: () async {
                    await _showShareOptions(context);
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.all(20)),
                    backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xFFF5F6F9)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.people,
                        color: Colors.black,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          "Invite a friend",
                          style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Colors.grey),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the login page and remove all routes below it
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                          (Route<dynamic> route) => false,
                    );
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.all(20)),
                    backgroundColor: MaterialStateColor.resolveWith((states) => Color(0xFFF5F6F9)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.black,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Row(
        children: [
          Container(
              width: 120.0, // Adjust the width based on your design
              height: 60.0,
              color: Colors.white,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(10),
            // ),
            ),
          SizedBox(width: 20),
          Container(
            width: 120.0, // Adjust the width based on your design
            height: 60.0,
            color: Colors.white,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(10),
            // ),
          ),
        ],
      ),
    );
  }
}

