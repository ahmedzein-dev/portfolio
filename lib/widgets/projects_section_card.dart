import 'package:flutter/material.dart';

import '../utils/functions.dart';
import '../utils/style.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // const Text(
      //   'Projects',
      //   style: TextStyle(
      //     fontSize: 40,
      //     fontWeight: FontWeight.bold,
      //     color: Color(0xFF2C3E50),
      //   ),
      // ),
      //const SizedBox(height: 30),
      // _buildProjectCard(
      //   title: 'RAK Rent',
      //   description: 'Real-estate rentals in UAE.',
      //   features: [
      //     'User App: Search and filtering for cars, reservation management',
      //     'Provider App: Car status tracking, payouts system',
      //     'Stripe Payment System with connected accounts and webhooks',
      //   ],
      //   techTags: ['Flutter', 'Stripe', 'Google Maps', 'Document Scanning'],
      //   gradient: [Color(0xFF4FACFE), Color(0xFF00F2FE)],
      //   icon: '🚗',
      //   url: '',
      // ),
      // SizedBox(height: 30),
      _buildProjectCard(
        title: 'Gainz AI',
        description: 'AI-powered fitness app with personalized training.',
        features: [
          'Hyper-realistic AI athlete avatars and adaptive training plans',
          'Real-time coaching and personalized workouts',
          'Published Flutter package: Scroll Highlight Text',
        ],
        techTags: ['Flutter', 'AI Operations', 'Package Development', 'UI/UX'],
        icon: '🦾',
        // NEW ICON
        url:
            'https://apps.apple.com/us/app/gainz-ai-chat-train-track/id6474649083',
      ),
      const SizedBox(height: 30),
      _buildProjectCard(
        title: 'BA3 Business Solution',
        description:
            'Cross-platform business solution handling 3.5M AED monthly.',
        features: [
          'Cross-platform (Android, iOS, Windows, macOS, Web)',
          'Dashboard & Analytics with comprehensive business insights',
          'Multi-language support (6 languages including Arabic, English)',
        ],
        techTags: [
          'Flutter',
          'Cross-platform',
          'Financial Systems',
          'Multi-language',
        ],
        icon: '🧾',
        url: '',
      ),
      const SizedBox(height: 30),
      _buildProjectCard(
        title: 'Spark Gym',
        description:
            'Group training in supportive, coach-led environments tailored to optimize personal fitness.',
        features: [
          'Personalized training activities',
          'Real-time monitoring by coaches',
        ],
        techTags: ['Flutter', 'Fitness', 'UI/UX'],
        icon: '🏋️‍♂️',
        url: 'https://apps.apple.com/ae/app/spark-fitness/id6450647441?l=ar',
      ),

      const SizedBox(height: 30),
      _buildProjectCard(
        title: 'Vision School',
        description:
            'A school management system for handling attendance, salaries, schedules, NFC-based check-ins.',
        features: [
          'Complete school management system',
          'Automated NFC attendance',
          'Student and staff record handling',
        ],
        techTags: ['Web', 'Flutter', 'NFC', 'Database'],
        icon: '🏫',
        url: 'https://ba3.co/vision/',
      ),

      const SizedBox(height: 30),
      _buildProjectCard(
        title: 'Osta Home',
        description:
            'Commercial real estate and construction marketplace with expert negotiation, rating, and scheduling tools.',
        features: [
          'Direct contact with verified experts',
          'Broker ID system and work scheduling',
          'Directories for furnishing and supply companies',
        ],
        techTags: ['Flutter', 'Marketplace', 'Real Estate'],
        icon: '🏘️',
        url: 'https://play.google.com/store/apps/details?id=com.home_osta.Osta',
      ),

      const SizedBox(height: 30),
      _buildProjectCard(
        title: 'Al-Taher Jewelry',
        description:
            'Client and manager apps for managing real-time gold prices, products, and store operations.',
        features: [
          'Client app with gold prices and search',
          'Manager app for inventory and price updates',
        ],
        techTags: ['Flutter', 'Retail', 'Dual App'],
        icon: '💎',
        url:
            'https://play.google.com/store/apps/details?id=ahmedzein.taher.jewellery.altaher_jewellery&pcampaignid=web_share',
      ),

      const SizedBox(height: 30),
      _buildProjectCard(
        title: 'Chefchaoun',
        description:
            'Coworking spaces with lecture halls, events, workshops, and stargazing trips in an inspiring environment.',
        features: [
          'Space rentals for meetings and events',
          'Community activities and trips',
        ],
        techTags: ['Flutter', 'Booking System', 'Community'],
        icon: '🌌',
        url: 'https://apps.apple.com/eg/app/chefchaoun/id1601105136',
      ),

      const SizedBox(height: 30),
      _buildProjectCard(
        title: 'Maharaja Restaurants',
        description:
            'Introduced Indian cuisine brand in Syria & Egypt with rich cultural and culinary experience.',
        features: [
          'Brand setup and expansion',
          'Traditional menu & vibrant hospitality',
        ],
        techTags: ['Branding', 'F&B', 'Operations'],
        icon: '🍛',
        url:
            'https://play.google.com/store/apps/details?id=com.maharaja_eg.maharaja_manager&pcampaignid=web_share',
      ),

      const SizedBox(height: 30),
      _buildProjectCard(
        title: 'Fitn Kitchen',
        description:
            'Health-focused app for calculating body mass and staying updated with the latest in diet and fitness.',
        features: [
          'BMI calculator and weight tracking',
          'Diet tips and body goals monitoring',
        ],
        techTags: ['Flutter', 'Fitness', 'Health'],
        icon: '🥗',
        url:
            'https://play.google.com/store/apps/details?id=com.fitnkitchen&pcampaignid=web_share',
      ),

      const SizedBox(height: 30),
      _buildProjectCard(
        title: 'Ikoo Media',
        description:
            'Streamlined e-marketing solution with fast campaign launches and consistent service quality.',
        features: ['Easy-to-use campaign tools', 'Time-saving automation'],
        techTags: ['Marketing', 'Automation', 'Web'],
        icon: '📣',
        url:
            'https://play.google.com/store/apps/details?id=com.ikoomedia&pcampaignid=web_share',
      ),

      const SizedBox(height: 30),
      _buildProjectCard(
        title: 'IBM Pharma',
        description:
            'Medical booking system allowing patients to find doctors and book appointments easily.',
        features: [
          'Doctor search and appointment scheduling',
          'Secure login and patient record handling',
        ],
        techTags: ['Flutter', 'Medical', 'Booking'],
        icon: '💊',
        url:
            'https://play.google.com/store/apps/details?id=com.ibm.pharma&pcampaignid=web_share',
      ),
    ],
  );
}

Widget _buildProjectCard({
  required String title,
  required String description,
  required List<String> features,
  required List<String> techTags,
  required String icon,
  required String url,
}) => Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withAlpha(20),
        blurRadius: 15,
        offset: const Offset(0, 4),
      ),
    ],
  ),
  child: LayoutBuilder(
    builder: (context, constraints) {
      if (constraints.maxWidth > 900) {
        return Padding(
          padding: const EdgeInsets.all(25),
          child: Row(
            spacing: 25,
            children: [
              // Project Image
              Container(
                width: 300,
                height: 250,
                decoration: const BoxDecoration(
                  color: AppStyle.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Center(
                  child: Text(icon, style: const TextStyle(fontSize: 80)),
                ),
              ),
              // Project Content
              Expanded(
                child: _buildProjectContent(
                  title,
                  description,
                  url,
                  features,
                  techTags,
                ),
              ),
            ],
          ),
        );
      } else {
        return Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                color: AppStyle.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Center(
                child: Text(icon, style: const TextStyle(fontSize: 80)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: _buildProjectContent(
                title,
                description,
                url,
                features,
                techTags,
              ),
            ),
          ],
        );
      }
    },
  ),
);

Widget _buildProjectContent(
  String title,
  String description,
  String url,
  List<String> features,
  List<String> techTags,
) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C3E50),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(color: Color(0xFF6C757D), fontSize: 16),
              ),
            ],
          ),
        ),
        Row(
          children: [
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(Icons.phone_android, color: Color(0xFF6C757D)),
            //   tooltip: 'Demo',
            // ),
            if (url.isNotEmpty)
              IconButton(
                onPressed: () {
                  if (url.isEmpty) {
                    return;
                  }
                  openUrl(url);
                },
                icon: const Icon(Icons.link, color: Color(0xFF6C757D)),
                tooltip: 'App Link',
              ),
          ],
        ),
      ],
    ),
    const SizedBox(height: 20),
    const Text(
      'Key Features:',
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: Color(0xFF2C3E50),
        fontSize: 16,
      ),
    ),
    const SizedBox(height: 10),
    ...features.map(
      (feature) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.only(top: 8, right: 12),
              decoration: const BoxDecoration(
                color: Color(0xFF3498DB),
                shape: BoxShape.circle,
              ),
            ),
            Expanded(
              child: Text(
                feature,
                style: const TextStyle(
                  color: Color(0xFF6C757D),
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    const SizedBox(height: 20),
    Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          techTags
              .map(
                (tag) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F9FA),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(
                      color: Color(0xFF495057),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
              .toList(),
    ),
  ],
);
