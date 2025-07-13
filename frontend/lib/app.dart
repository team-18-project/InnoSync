import 'package:flutter/material.dart';
import 'routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InnoSync',
      initialRoute: '/login',
      routes: appRoutes,
      // theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Roboto'),
      // home: const LoginFormPage(),
    );
  }
}
