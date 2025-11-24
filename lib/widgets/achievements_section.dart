import 'package:ahmed_portfolio/utils/functions.dart';
import 'package:flutter/material.dart';

class AchievementsSection extends StatelessWidget {
  const AchievementsSection({super.key});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'KEY ACHIEVEMENTS',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF10B981),
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Impact & Contributions',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 900) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildProjectAchievements(),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: _buildOpenSourceSection(),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildProjectAchievements(),
                    const SizedBox(height: 30),
                    _buildOpenSourceSection(),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProjectAchievements() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF10B981).withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'BA3 Business Solution',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Android, iOS, Windows, macOS, Web',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF10B981),
            ),
          ),
          const SizedBox(height: 24),
          _buildImpactItem(
            'Saved ~829 million Firestore reads/year (≈\$497/year)',
          ),
          _buildImpactItem(
            'Improved invoice creation speed by ~99%',
          ),
          _buildImpactItem(
            'Built custom desktop UI framework with floating windows & multi-monitor support',
          ),
          _buildImpactItem(
            'Handled 3.5M AED monthly transactions across 5 platforms',
          ),
          _buildImpactItem(
            'Implemented 6-language localization (Arabic, English, Urdu, German, French, Chinese)',
          ),
          const SizedBox(height: 24),
          const Text(
            'RAK Rent',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Android & iOS',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF10B981),
            ),
          ),
          const SizedBox(height: 24),
          _buildImpactItem(
            'Reduced development time by 40% with modular architecture',
          ),
          _buildImpactItem(
            'Created proprietary document scanning package eliminating third-party dependencies',
          ),
          _buildImpactItem(
            'Integrated Stripe Connected Accounts with 100% payment reliability',
          ),
        ],
      ),
    );
  }

  Widget _buildImpactItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8, right: 12),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Color(0xFF10B981),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFFCBD5E1),
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOpenSourceSection() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF10B981).withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Open Source Packages',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          _buildPackageCard(
            title: 'scroll_highlight_text',
            description: 'Flutter package for highlighting and scrolling through text in Latin and Arabic languages.',
            url: 'https://pub.dev/packages/scroll_highlight_text',
            stats: '42 likes • 160 points',
          ),
          const SizedBox(height: 16),
          _buildPackageCard(
            title: 'document_camera_frame',
            description: 'Customizable camera interface for capturing and cropping document images with auto-detection.',
            url: 'https://pub.dev/packages/document_camera_frame',
            stats: '42 likes • 160 points',
          ),
        ],
      ),
    );
  }

  Widget _buildPackageCard({
    required String title,
    required String description,
    required String url,
    required String stats,
  }) {
    return InkWell(
      onTap: () => openUrl(url),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF10B981).withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF10B981),
                    ),
                  ),
                ),
                const Icon(
                  Icons.open_in_new,
                  size: 18,
                  color: Color(0xFF10B981),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFFCBD5E1),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              stats,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF9CA3AF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
