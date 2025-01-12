import 'package:flutter/material.dart';
import 'package:iphone_v01/Home%20Page/home.dart';
import 'package:iphone_v01/signin/signup/signup.dart';
//import 'package:iphone_v01/MicPage/voice_recording_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}
