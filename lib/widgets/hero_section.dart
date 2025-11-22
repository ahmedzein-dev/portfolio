import 'package:ahmed_portfolio/utils/functions.dart';
import 'package:ahmed_portfolio/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    this.onViewWork,
    this.onGetInTouch,
  });

  final VoidCallback? onViewWork;
  final VoidCallback? onGetInTouch;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0F172A),
            Color(0xFF1E293B),
          ],
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 900) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAvailableBadge(),
                      const SizedBox(height: 30),
                      _buildTitle(),
                      const SizedBox(height: 20),
                      _buildDescription(),
                      const SizedBox(height: 40),
                      _buildCTAButtons(),
                    ],
                  ),
                ),
                const SizedBox(width: 60),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      const ProfileCard(),
                      const SizedBox(height: 30),
                      _buildStats(),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Column(
              children: [
                const ProfileCard(),
                const SizedBox(height: 30),
                _buildAvailableBadge(),
                const SizedBox(height: 20),
                _buildTitle(),
                const SizedBox(height: 20),
                _buildDescription(),
                const SizedBox(height: 30),
                _buildStats(),
                const SizedBox(height: 30),
                _buildCTAButtons(),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildAvailableBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF10B981), width: 1.5),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 8, color: Color(0xFF10B981)),
          SizedBox(width: 8),
          Text(
            'Available for work',
            style: TextStyle(
              color: Color(0xFF10B981),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Hi, I'm",
          style: TextStyle(
            fontSize: 24,
            color: Color(0xFF9CA3AF),
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Ahmed Zein Elabedin',
          style: TextStyle(
            fontSize: 56,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Flutter Developer',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: Color(0xFF10B981),
            height: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return const Text(
      'Passionate about crafting high-quality Flutter apps that merge functionality with stunning UI, creating experiences users love.',
      style: TextStyle(
        fontSize: 18,
        color: Color(0xFF9CA3AF),
        height: 1.6,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildCTAButtons() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        ElevatedButton(
          onPressed: onViewWork,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF10B981),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: const Text(
            'View My Work',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        OutlinedButton(
          onPressed: onGetInTouch,
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF10B981),
            side: const BorderSide(color: Color(0xFF10B981), width: 2),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Get In Touch',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem('5+', 'Years Experience'),
        _buildStatItem('20+', 'Projects Completed'),
      ],
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF9CA3AF),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

