import 'package:flutter/material.dart';
import 'package:haber_app/layout/news_layout.dart';

void main()=>runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.red,accentColor: Colors.white),
      home: NewsPage(),
    );
  }
}
