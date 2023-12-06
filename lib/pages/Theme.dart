import 'package:flutter/material.dart';

class Theme extends StatefulWidget {
  const Theme({super.key});

  @override
  State<Theme> createState() => _ThemeState();
}

class _ThemeState extends State<Theme> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Theme"),
        backgroundColor: Colors.black,
      ),
    );
  }
}
