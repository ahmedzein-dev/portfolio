import 'package:ahmed_portfolio/screens/home_screen.dart';
import 'package:ahmed_portfolio/screens/splash_screen.dart';
import 'package:ahmed_portfolio/utils/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Simple state management for theme mode
  final ValueNotifier<ThemeMode> _themeMode = ValueNotifier(ThemeMode.dark);

  void _toggleTheme() {
    _themeMode.value =
        _themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeMode,
      builder: (context, mode, child) {
        return MaterialApp(
          title: 'Ahmed Zein Elabedin - Portfolio',
          theme: AppTheme.lightTheme(context),
          darkTheme: AppTheme.darkTheme(context),
          themeMode: mode,
          home: Builder(
            builder: (navigatorContext) {
              return SplashScreen(
                onInitializationComplete: () {
                  // Navigate to Home after splash, passing the toggle callback
                  Navigator.of(navigatorContext).pushReplacement(
                    MaterialPageRoute(
                      builder:
                          (_) => PortfolioHomePage(
                            onThemeToggle: _toggleTheme,
                            isDarkMode: mode == ThemeMode.dark,
                          ),
                    ),
                  );
                },
              );
            },
          ),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
