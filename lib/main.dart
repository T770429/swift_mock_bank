import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(const SwiftBankApp());
}

class SwiftBankApp extends StatelessWidget {
  const SwiftBankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Swift Bank",
      theme: ThemeData(
        primaryColor: const Color(0xFFE53935),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        fontFamily: 'Arial',
      ),
      home: const HomePage(),
    );
  }
}