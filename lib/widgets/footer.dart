import 'package:ahmed_portfolio/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({
    super.key,
    this.onAboutTap,
    this.onServicesTap,
    this.onProjectsTap,
    this.onContactTap,
  });

  final VoidCallback? onAboutTap;
  final VoidCallback? onServicesTap;
  final VoidCallback? onProjectsTap;
  final VoidCallback? onContactTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      decoration: const BoxDecoration(color: Color(0xFF111827)),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 900) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ahmed Zein Elabedin',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Creating exceptional mobile experiences through innovative Flutter development.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF9CA3AF),
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: _buildNavigationColumn()),
                Expanded(child: _buildConnectColumn()),
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ahmed Zein Elabedin',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Creating exceptional mobile experiences through innovative Flutter development.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF9CA3AF),
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 40),
                _buildNavigationColumn(),
                const SizedBox(height: 40),
                _buildConnectColumn(),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildNavigationColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Navigation',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        _buildFooterLink('About', onAboutTap ?? () {}),
        const SizedBox(height: 12),
        _buildFooterLink('Services', onServicesTap ?? () {}),
        const SizedBox(height: 12),
        _buildFooterLink('Projects', onProjectsTap ?? () {}),
        const SizedBox(height: 12),
        _buildFooterLink('Contact', onContactTap ?? () {}),
      ],
    );
  }

  Widget _buildConnectColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Connect',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        _buildFooterLink('LinkedIn', () {
          openUrl(
            'https://www.linkedin.com/in/ahmed-zein-294230270',
            mode: LaunchMode.externalApplication,
          );
        }),
        const SizedBox(height: 12),
        _buildFooterLink('GitHub', () {
          openUrl(
            'https://github.com/ahmedzein-dev',
            mode: LaunchMode.externalApplication,
          );
        }),
        const SizedBox(height: 12),
        _buildFooterLink('Email', () {
          final Uri emailUri = Uri(
            scheme: 'mailto',
            path: 'ahmed.zein1896@gmail.com',
          );
          openUrl(emailUri.toString(), mode: LaunchMode.externalApplication);
        }),
      ],
    );
  }

  Widget _buildFooterLink(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Color(0xFF9CA3AF)),
      ),
    );
  }
}
