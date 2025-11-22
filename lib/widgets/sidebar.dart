import 'package:ahmed_portfolio/widgets/tech_stack_card.dart';
import 'package:flutter/material.dart';

import 'about_card.dart';
import 'certifications_card.dart';
import 'experience_card.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key, required this.constraints});

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      // ProfileCard(),
      // const SizedBox(height: 30),
      const AboutCard(),
      const SizedBox(height: 30),
      const ExperienceCard(),
      //  const SizedBox(height: 30),
      const TechStackCard(),

      if (constraints.maxWidth > 900)
        const Column(
          children: [
            SizedBox(height: 30),
            CertificationsCard(),
            SizedBox(height: 30),
          ],
        ),
    ],
  );
}
