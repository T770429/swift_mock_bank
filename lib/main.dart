import 'package:flutter/material.dart';

import 'api/bpi_api_service.dart';
import 'data/bank_repository.dart';
import 'home_page.dart';
import 'profile_page.dart';

void main() {
  runApp(const SwiftBankApp());
}

class SwiftBankApp extends StatefulWidget {
  const SwiftBankApp({super.key, this.repository});

  final BankRepository? repository;

  @override
  State<SwiftBankApp> createState() => _SwiftBankAppState();
}

class _SwiftBankAppState extends State<SwiftBankApp> {
  late final BpiApiService _apiService;
  late final BankRepository _repository;

  @override
  void initState() {
    super.initState();

    _apiService = BpiApiService(
      baseUrl: 'http://127.0.0.1:8001',
    );

    _repository = widget.repository ?? BankRepository(apiService: _apiService);
  }

  @override
  void dispose() {
    _apiService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData baseTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFD32F2F),
        primary: const Color(0xFFD32F2F),
      ),
      scaffoldBackgroundColor: const Color(0xFFF6F7FB),
      cardTheme: CardThemeData(
        elevation: 2,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Swift Bank',
      theme: baseTheme,
      initialRoute: HomePage.routeName,
      routes: <String, WidgetBuilder>{
        HomePage.routeName: (_) => HomePage(repository: _repository),
        ProfilePage.routeName: (_) => ProfilePage(repository: _repository),
      },
    );
  }
}
