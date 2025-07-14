import 'package:flutter/material.dart';
import 'routes.dart';
import 'theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InnoSync',
      initialRoute: '/login',
      routes: appRoutes,
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: AppTheme.primaryColor,
        scaffoldBackgroundColor: AppTheme.backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppTheme.appBarColor,
          foregroundColor: AppTheme.tabLabelColor,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: AppTheme.primaryButtonStyle,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
        tabBarTheme: const TabBarThemeData(
          labelColor: AppTheme.tabLabelColor,
          unselectedLabelColor: AppTheme.primaryColor,
          indicatorColor: AppTheme.primaryColor,
        ),
        cardTheme: CardThemeData(
          color: AppTheme.cardBackgroundColor,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
