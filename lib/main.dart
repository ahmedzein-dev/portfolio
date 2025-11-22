import 'package:ahmed_portfolio/screens/home_screen.dart';
<<<<<<< HEAD
import 'package:ahmed_portfolio/screens/splash_screen.dart';
=======
>>>>>>> 3b06d18a1555965556e30adaeac731e9128addac
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Ahmed Zein Elabedin - Portfolio',
    theme: ThemeData(
<<<<<<< HEAD
      primaryColor: const Color(0xFF4F46E5),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF4F46E5),
        primary: const Color(0xFF4F46E5),
      ),
      textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
      useMaterial3: true,
    ),
    home: const SplashScreen(),
=======
      primarySwatch: Colors.blue,
      textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
    ),
    home: const PortfolioHomePage(),
>>>>>>> 3b06d18a1555965556e30adaeac731e9128addac
    debugShowCheckedModeBanner: false,
  );
}
