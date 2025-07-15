import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'routes.dart';
import 'theme/app_theme.dart';
import 'theme/colors.dart';

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
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        textTheme: GoogleFonts.montserratTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.textPrimary,
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
          labelColor: AppColors.textOnPrimary,
          unselectedLabelColor: AppColors.primary,
          indicatorColor: AppColors.primary,
        ),
        cardTheme: CardThemeData(
          color: AppColors.cardBackground,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
