import 'package:flutter/material.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Services',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'What I Do',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFF9CA3AF),
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'I offer comprehensive mobile development services to bring your ideas to life',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF9CA3AF),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 60),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 900) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildServiceCard(
                      number: '01',
                      title: 'Cross-Platform Development',
                      description: 'Building high-quality applications for mobile, web, and desktop platforms using Flutter, delivering seamless experiences across all devices.',
                      features: [
                        'Mobile app development (iOS & Android)',
                        'Web application development',
                        'Desktop application development',
                        'Custom UI components',
                        'API Integration',
                      ],
                    )),
                    const SizedBox(width: 30),
                    Expanded(child: _buildServiceCard(
                      number: '02',
                      title: 'Code Refactoring & Optimization',
                      description: 'Improving existing codebases through refactoring, bug fixing, and performance optimization to enhance maintainability and efficiency.',
                      features: [
                        'Code refactoring',
                        'Bug fixing and debugging',
                        'Performance optimization',
                        'Legacy code modernization',
                        'Code quality enhancement',
                      ],
                    )),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildServiceCard(
                      number: '01',
                      title: 'Cross-Platform Development',
                      description: 'Building high-quality applications for mobile, web, and desktop platforms using Flutter, delivering seamless experiences across all devices.',
                      features: [
                        'Mobile app development (iOS & Android)',
                        'Web application development',
                        'Desktop application development',
                        'Custom UI components',
                        'API Integration',
                      ],
                    ),
                    const SizedBox(height: 30),
                    _buildServiceCard(
                      number: '02',
                      title: 'Code Refactoring & Optimization',
                      description: 'Improving existing codebases through refactoring, bug fixing, and performance optimization to enhance maintainability and efficiency.',
                      features: [
                        'Code refactoring',
                        'Bug fixing and debugging',
                        'Performance optimization',
                        'Legacy code modernization',
                        'Code quality enhancement',
                      ],
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard({
    required String number,
    required String title,
    required String description,
    required List<String> features,
  }) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFD4AA7D).withValues(alpha: 0.2),
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
          Text(
            number,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFFD4AA7D),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF9CA3AF),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),
          ...features.map((feature) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 8, right: 12),
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFFD4AA7D),
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    feature,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFFCBD5E1),
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          )),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFD4AA7D),
              side: const BorderSide(color: Color(0xFFD4AA7D), width: 2),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Get Started',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
