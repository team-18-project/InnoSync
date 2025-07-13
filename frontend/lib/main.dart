import 'package:flutter/material.dart';
import 'screens/login_form.dart';
import 'screens/profile_creation_page.dart';
import 'screens/dashboard_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InnoSync',
      theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Roboto'),
      home: const LoginFormPage(),
    );
  }
}
