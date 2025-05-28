import 'package:ahmed_portfolio/widgets/certifications_card.dart';
import 'package:ahmed_portfolio/widgets/projects_section_card.dart';
import 'package:ahmed_portfolio/widgets/sidebar.dart';
import 'package:flutter/material.dart';

import '../widgets/education_card.dart';
import '../widgets/header.dart';
import '../widgets/open_source_section.dart';

class PortfolioHomePage extends StatelessWidget {
  const PortfolioHomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF8F9FA),
    body: SingleChildScrollView(
      child: Container(
        // constraints: BoxConstraints(maxWidth: 1200),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // Header Section
            const HeaderSection(),

            // Main Content
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 900) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Sidebar
                      Expanded(
                        flex: 1,
                        child: Sidebar(constraints: constraints),
                      ),
                      const SizedBox(width: 40),
                      // Projects Section
                      const Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            ProjectsSection(),
                            SizedBox(height: 30),
                            OpenSourceSection(),
                            SizedBox(height: 30),
                            EducationCard(),
                            SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Sidebar(constraints: constraints),
                      const SizedBox(height: 30),
                      const ProjectsSection(),
                      const SizedBox(height: 30),
                      const OpenSourceSection(),
                      const SizedBox(height: 30),
                      const CertificationsCard(),
                      const SizedBox(height: 30),
                      const EducationCard(),
                      const SizedBox(height: 30),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    ),
  );
}
