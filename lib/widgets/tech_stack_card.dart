import 'package:flutter/material.dart';

class TechStackCard extends StatelessWidget {
  const TechStackCard({super.key});

  static const coreTechStack = [
    {
      'name': 'Flutter',
      'icon': '🚀',
      'colors': [Color(0xFF02569B), Color(0xFF5DADE2)],
    },
    {
      'name': 'Dart',
      'icon': '🎯',
      'colors': [Color(0xFF0175C2), Color(0xFF40E0D0)],
    },
    {
      'name': 'Java',
      'icon': '🔥',
      'colors': [Color(0xFFFFCA28), Color(0xFFFF6F00)],
    },
    {
      'name': 'SQL Database',
      'icon': '🗄️',
      'colors': [Color(0xFF00618A), Color(0xFF4479A1)],
    },
  ];

  static const toolsTechnologies = [
    'Firebase',
    'Postman',
    'Jira',
    'Trello',
    'Slack',
    'Asana',
    'Android Studio',
    'Visual Studio Code',
  ];

  static const programmingConcepts = [
    'Clean Code',
    'Clean Architecture',
    'OOP & SOLID Principles',
    'Algorithms & Data Structures',
    'Design Patterns',
    'Problem Solving',
  ];

  static const flutterSkills = [
    'Cross-platform Development',
    'Provider, Bloc, Cubit, GetX',
    'Firebase Auth, Firestore, FCM',
    'Retrofit, Dio, Http',
    'REST & GraphQL APIs',
    'Isolates & Streams',
    'Shared Preferences, Hive, Sqflite',
    'Stripe, PayPal, Razorpay, Google/Apple Pay',
    'Push Notifications',
    'Google Maps',
    'Responsive UI',
    'Localization & Animations',
    'Flutter Flavors',
    'CI/CD (GitHub Actions, Fastlane)',
    'Testing & Debugging',
    'Platform Channels (Kotlin & Swift)',
    'Git & GitHub',
    'Open Source Contributions',
  ];

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(18),
          blurRadius: 10,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    padding: const EdgeInsets.all(25),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tech Stack & Skills',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
          const SizedBox(height: 20),

          // Core Tech Stack Grid
          const Text(
            'Core Tech Stack',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF34495E),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 12,
            children:
                coreTechStack
                    .map(
                      (item) => Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        // Adjust as needed
                        constraints: const BoxConstraints(
                          minWidth: 140,
                          maxWidth: 180,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F9FA),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: item['colors'] as List<Color>,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  item['icon'] as String,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              item['name'] as String,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2C3E50),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
          ),

          const SizedBox(height: 25),

          // Tools & Technologies
          const Text(
            'Tools & Technologies',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF34495E),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children:
                toolsTechnologies
                    .map(
                      (tool) => Chip(
                        label: Text(
                          tool,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        backgroundColor: const Color(0xFFEEF2F2),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                      ),
                    )
                    .toList(),
          ),
          const SizedBox(height: 25),

          // Programming Concepts
          const Text(
            'Programming & Software Development',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF34495E),
            ),
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                programmingConcepts
                    .map(
                      (concept) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '• ',
                              style: TextStyle(fontSize: 20, height: 1.3),
                            ),
                            Expanded(
                              child: Text(
                                concept,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF555555),
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
          ),
          const SizedBox(height: 25),

          // Flutter Ecosystem
          const Text(
            'Flutter Ecosystem & Advanced Skills',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF34495E),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                flutterSkills
                    .map(
                      (skill) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEF2F2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          skill,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF1B2733),
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    ),
  );
}
