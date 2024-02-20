import 'package:flutter/material.dart';
import 'package:todo/screen/home_screen.dart';

import 'package:todo/screen/login.dart';

import 'package:todo/widget/custtomDrawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: statu == false ? ThemeData.dark() : ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: const Login(),
    );
  }
}
