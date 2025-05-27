import 'package:ahmed_portfolio/utils/functions.dart';
import 'package:flutter/material.dart';

class CertificationsCard extends StatelessWidget {
  const CertificationsCard({super.key});

  final List<Map<String, String>> certifications = const [
    {
      'year': '2020',
      'title': 'One Million Arab Coders Initiative',
      'subtitle': 'Udacity',
      'url':
          'https://s3-us-west-2.amazonaws.com/udacity-printer/production/certificates/e7027a0a-1057-4144-aac2-ebb075e11928.pdf',
    },
    {
      'year': '2021',
      'title': 'Algorithms Specialization',
      'subtitle': 'Stanford University',
      'url': 'https://coursera.org/share/0bc91d7dc2aafd6f331ad9185816338a',
    },
    {
      'year': '2021',
      'title': 'Object Oriented Programming in Java',
      'subtitle': 'University of California San Diego',
      'url': 'https://coursera.org/share/0dc26bea6c5f4e9d6149f9ed28195b31',
    },
    {
      'year': '2025',
      'title': 'Algorithms Analysis and Design From Scratch',
      'subtitle': 'Cloud Native Base Camp',
      'url':
          'https://drive.google.com/file/d/1tC71lDIh2XnAcl8QkFGij08oaFRLR3WQ/view?usp=sharing',
    },
    {
      'year': '2024',
      'title': 'Data Structures Decode',
      'subtitle': 'Cloud Native Base Camp',
      'url':
          'https://drive.google.com/file/d/1eCV522zFBvd7AyxKyeLacaZdh8kcnApr/view?usp=drivesdk',
    },
  ];

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(13),
          blurRadius: 6,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    padding: const EdgeInsets.all(25),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Certifications',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 15),
        ...certifications.map(
          (cert) => Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9ECEF),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    cert['year']!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF495057),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => openUrl(cert['url']!),
                        child: Text(
                          cert['title']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      if (cert['subtitle']!.isNotEmpty)
                        const SizedBox(height: 2),
                      if (cert['subtitle']!.isNotEmpty)
                        Text(
                          cert['subtitle']!,
                          style: const TextStyle(
                            color: Color(0xFF6C757D),
                            fontSize: 14,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
