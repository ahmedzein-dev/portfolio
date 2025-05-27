import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/functions.dart';

class ExperienceCard extends StatelessWidget {
  const ExperienceCard({super.key});

  final List<Map<String, dynamic>> experiences = const [
    {
      'title': 'Senior Software Engineer',
      'company': 'Kief Consultancy & Technology · Full-time',
      'location': 'Abu Dhabi, United Arab Emirates · On-site',
      'period': 'May 2025 - Present',
      'link': 'https://kief.ae/',
      'details': [],
    },
    {
      'title': 'Senior Software Engineer',
      'company': 'BA3.co · Full-time',
      'location': 'Ras al-Khaimah, United Arab Emirates · On-site',
      'period': 'Jul 2024 - May 2025',
      'link': 'https://ba3.co/',
      'details': [
        'Led development of RAK Rent (Android, iOS) apps for car rentals with search, reservation management, Stripe payments, and Google Maps integration.',
        'Built document_camera_frame Flutter package for document scanning (licenses, passports, etc).',
        'Created provider app with real-time car status, payouts, and refund handling.',
        'Developed BA3 Business Solution (Android, iOS, Windows, macOS, Web) handling 3.5M AED/month with features like dashboards, billing, user roles, WhatsApp API, and localization.',
        'Implemented financial modules: bonds, cheques, e-invoicing, customer/seller management, and tax reporting.',
        'Engineered custom floating windows for desktop platforms with priority-based, resizable, reusable dialogs and popups.',
        'Enabled data import/export (JSON, XML), advanced printing, and end-of-year financial migration handling.',
        'Designed modular, scalable architecture with shared widgets and reusable components to reduce future dev costs.',
        'Supported multi-language UI (Arabic, English, Urdu, German, French, Chinese) and robust activity/event logging with filtering and exporting.',
        'Tech used: Flutter, Dart, Stripe API, Google Maps, Windows/macOS Platform Channels, Printing APIs, Modular Architecture, Localization, Desktop UI Workarounds.',
      ],
    },
    {
      'title': 'Mid-Senior Mobile App Developer',
      'company': 'GAINZ.AI · Contract',
      'location': 'London, England · Remote',
      'period': 'Feb 2024 - May 2024',
      'link': 'https://www.gainz.ai/',
      'details': [
        'Built AI-powered fitness app with personalized workout plans and a smart notepad system.',
        'Implemented advanced search across note content, categories, and coach data with in-text highlighting and auto-scroll.',
        'Published open-source Flutter package (Scroll Highlight Text) on pub.dev to aid developers with in-app search UX.',
        'Integrated AI features like note summarization and translation directly into the app.',
        'Designed and optimized Note Categories and Note Details screens for responsive UI and seamless UX.',
        'Received LinkedIn recommendation from Mobile Team Lead for exceptional performance and teamwork.',
        'Tech used: Flutter, Dart, UI/UX Design, Package Development, AI integration, Scalability.',
      ],
    },
    {
      'title': 'Junior Mobile App Developer',
      'company': 'Xtreme Digital · Full-time',
      'location': 'Cairo, Egypt · On-site',
      'period': 'Jan 2022 - Jan 2024',
      'link':
          'https://play.google.com/store/apps/developer?id=Xtreme+Digital+Services+Agency',
      'details': [
        'Led mobile app development from concept to release.',
        'Reduced cost and time by improving app workflows.',
        'Launched 8+ apps on App Store and Play Store.',
      ],
    },
    {
      'title': 'Junior Mobile App Developer',
      'company': 'LINNSTÄD I STOCKHOLM AB · Contract',
      'location': 'Stockholm County, Sweden · Remote',
      'period': 'Jul 2021 - Dec 2021',
      'link': 'https://www.linnstad.se/',
      'details': [
        'Solely handled mobile development for a cleaning service app with 10,000+ active users.',
        'Managed all lifecycle stages including deployment.',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
        experiences
            .map(
              (exp) => Container(
                margin: const EdgeInsets.only(bottom: 25),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(15),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap:
                                    () => openUrl(
                                      exp['link'],
                                      mode: LaunchMode.externalApplication,
                                    ),
                                child: Text(
                                  exp['title'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap:
                                    () => openUrl(
                                      exp['link'],
                                      mode: LaunchMode.externalApplication,
                                    ),
                                child: Text(
                                  exp['company'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    exp['period'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    exp['location'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ...((exp['details'] as List).map<Widget>(
                      (detail) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('• '),
                            Expanded(
                              child: Text(
                                detail,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            )
            .toList(),
  );
}
