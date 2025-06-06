import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/site_validity_screen.dart';
import 'screens/extracting_license_screen.dart';
import 'screens/service_choice_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BINAA بناء',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/service-choice': (context) => const ServiceChoiceScreen(),
        '/extracting-license': (context) => const ExtractingLicenseScreen(),
        '/site-validity': (context) => const SiteValidityScreen(),
      },
    );
  }
}
