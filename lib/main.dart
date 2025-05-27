import 'package:ahmed_portfolio/screens/home_screen.dart';
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
      primarySwatch: Colors.blue,
      textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
    ),
    home: const PortfolioHomePage(),
    debugShowCheckedModeBanner: false,
  );
}
