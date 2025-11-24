import 'package:ahmed_portfolio/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, this.onInitializationComplete});

  final VoidCallback? onInitializationComplete;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _lineController;
  late AnimationController _dotsController;
  late Animation<double> _lineAnimation;

  @override
  void initState() {
    super.initState();
    _lineController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _dotsController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();

    _lineAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _lineController, curve: Curves.easeInOut),
    );

    _lineController.forward();

    // Navigate to home after animation
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        // Stop all animations before navigation
        _dotsController.stop();
        _lineController.stop();

        if (widget.onInitializationComplete != null) {
          widget.onInitializationComplete!();
        } else {
          // Fallback for standalone usage
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder:
                  (context, animation, secondaryAnimation) =>
                      const PortfolioHomePage(),
              transitionDuration: const Duration(milliseconds: 500),
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    // Stop animations before disposing
    _dotsController.stop();
    _lineController.stop();
    _lineController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // AZ Text - appears immediately
            const Text(
              'AZ',
              style: TextStyle(
                fontSize: 120,
                fontWeight: FontWeight.w300,
                color: Color(0xFF10B981),
                letterSpacing: 8,
              ),
            ),
            const SizedBox(height: 24),
            // Three dots with animation
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return AnimatedBuilder(
                  animation: _dotsController,
                  builder: (context, child) {
                    final delay = index * 0.2;
                    final animationValue =
                        (_dotsController.value + delay) % 1.0;
                    final opacity =
                        (animationValue < 0.5)
                            ? 0.3 + (animationValue * 1.4)
                            : 1.0 - ((animationValue - 0.5) * 1.4);
                    final scale =
                        0.8 +
                        (animationValue < 0.5
                            ? animationValue * 0.4
                            : (1.0 - animationValue) * 0.4);

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      child: Transform.scale(
                        scale: scale,
                        child: Opacity(
                          opacity: opacity.clamp(0.3, 1.0),
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFF10B981),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            const SizedBox(height: 24),
            // Horizontal line with loading animation
            AnimatedBuilder(
              animation: _lineAnimation,
              builder: (context, child) {
                return Container(
                  width: 200,
                  height: 2,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(1),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 200 * _lineAnimation.value,
                      height: 2,
                      decoration: const BoxDecoration(
                        color: Color(0xFF10B981),
                        borderRadius: BorderRadius.all(Radius.circular(1)),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
