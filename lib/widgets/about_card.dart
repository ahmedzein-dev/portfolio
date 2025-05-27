import 'package:flutter/material.dart';

class AboutCard extends StatelessWidget {
  const AboutCard({super.key});

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
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 28),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About Me',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1B2733),
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 20),
        Text.rich(
          TextSpan(
            style: TextStyle(
              color: Color(0xFF495057),
              fontSize: 17,
              height: 1.7,
              letterSpacing: 0.3,
              fontWeight: FontWeight.w400,
            ),
            children: [
              TextSpan(
                text:
                    'Highly skilled mobile app developer with 5 years of experience, including 4 years specializing in Dart and Flutter, committed to delivering high-quality mobile app development. ',
              ),
              TextSpan(
                text:
                    'With a proven track record in UI/UX design and performance optimization, I expertly select tools tailored to each situation and leverage testing and profiling to enhance performance.\n\n',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              TextSpan(
                text:
                    'Effective collaboration is a cornerstone of my approach, combining a strong foundation in science and technology with a passion for staying at the forefront of industry trends. I am results-oriented, continuously improving, and ready to tackle challenges with technical expertise and an unshakeable drive for success.\n\n',
              ),
              TextSpan(
                text:
                    'My portfolio includes numerous apps available on the App Store and Google Play Store. Additionally, I have extensive experience working on both remote and on-site projects with diverse teams across various countries.',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF6C757D),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
