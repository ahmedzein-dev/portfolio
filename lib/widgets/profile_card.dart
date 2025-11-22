import 'dart:math' as math;

import 'package:flutter/material.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _floatController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(duration: const Duration(seconds: 20), vsync: this)..repeat();

    _floatController = AnimationController(duration: const Duration(seconds: 2), vsync: this)..repeat(reverse: true);
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 420,
      height: 500,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Second rotating circle (opposite direction)
          AnimatedBuilder(
            animation: _rotationController,
            builder: (context, child) {
              return Transform.rotate(
                angle: -_rotationController.value * 2 * math.pi,
                child: Container(
                  width: 380,
                  height: 380,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF10B981).withOpacity(0.15), width: 1),
                  ),
                ),
              );
            },
          ),

          // Main profile image container
          Container(
            width: 320,
            height: 320,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF10B981).withOpacity(0.5), width: 2),
              boxShadow: [BoxShadow(color: const Color(0xFF10B981).withOpacity(0.2), blurRadius: 30, spreadRadius: 5)],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/about600.png',
                fit: BoxFit.contain, // Shows full image
                alignment: Alignment.center,
              ),
            ),
          ),

          // Floating Tech Badges
          // Flutter Badge - Top Right
          AnimatedBuilder(
            animation: _floatController,
            builder: (context, child) {
              return Positioned(
                top: 30 + (_floatController.value * 10),
                right: 20,
                child: _buildTechBadge(icon: Icons.flutter_dash, label: 'Flutter', color: const Color(0xFF02569B)),
              );
            },
          ),

          // Mobile Badge - Left
          AnimatedBuilder(
            animation: _floatController,
            builder: (context, child) {
              return Positioned(
                left: 0,
                top: 200 + (_floatController.value * 8),
                child: _buildTechBadge(icon: Icons.phone_android, label: 'Mobile', color: const Color(0xFF10B981)),
              );
            },
          ),

          // Web Badge - Right
          AnimatedBuilder(
            animation: _floatController,
            builder: (context, child) {
              return Positioned(
                right: 0,
                top: 280 + (_floatController.value * 12),
                child: _buildTechBadge(icon: Icons.web, label: 'Web', color: const Color(0xFF8B5CF6)),
              );
            },
          ),

          // Desktop Badge - Bottom Right
          AnimatedBuilder(
            animation: _floatController,
            builder: (context, child) {
              return Positioned(
                bottom: 40 + (_floatController.value * 10),
                right: 40,
                child: _buildTechBadge(icon: Icons.desktop_windows, label: 'Desktop', color: const Color(0xFF4F46E5)),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTechBadge({required IconData icon, required String label, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
