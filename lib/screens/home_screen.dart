import 'package:ahmed_portfolio/widgets/about_card.dart';
import 'package:ahmed_portfolio/widgets/achievements_section.dart';
import 'package:ahmed_portfolio/widgets/animated_section.dart';
import 'package:ahmed_portfolio/widgets/contact_section.dart';
import 'package:ahmed_portfolio/widgets/featured_projects_section.dart';
import 'package:ahmed_portfolio/widgets/footer.dart';
import 'package:ahmed_portfolio/widgets/hero_section.dart';
import 'package:ahmed_portfolio/widgets/navigation_header.dart';
import 'package:ahmed_portfolio/widgets/projects_section_card.dart';
import 'package:ahmed_portfolio/widgets/services_section.dart';
import 'package:flutter/material.dart';

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _achievementsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Column(
        children: [
          // Navigation Header
          NavigationHeader(
            onAboutTap: () => _scrollToSection(_aboutKey),
            onServicesTap: () => _scrollToSection(_servicesKey),
            onProjectsTap: () => _scrollToSection(_projectsKey),
            onContactTap: () => _scrollToSection(_contactKey),
          ),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // Hero Section
                  AnimatedSection(
                    delay: 100,
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: HeroSection(
                        onViewWork: () => _scrollToSection(_projectsKey),
                        onGetInTouch: () => _scrollToSection(_contactKey),
                      ),
                    ),
                  ),

                  // About Section
                  ScrollAwareAnimatedSection(
                    scrollController: _scrollController,
                    threshold: 0.15,
                    child: Container(
                      key: _aboutKey,
                      constraints: const BoxConstraints(maxWidth: 1200),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: AboutCard(
                        onViewWork: () => _scrollToSection(_projectsKey),
                        onWorkTogether: () => _scrollToSection(_contactKey),
                      ),
                    ),
                  ),

                  // Services Section
                  ScrollAwareAnimatedSection(
                    scrollController: _scrollController,
                    threshold: 0.15,
                    child: Container(
                      key: _servicesKey,
                      constraints: const BoxConstraints(maxWidth: 1200),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: const ServicesSection(),
                    ),
                  ),

                  // Featured Projects Section
                  ScrollAwareAnimatedSection(
                    scrollController: _scrollController,
                    threshold: 0.15,
                    child: Container(
                      key: _projectsKey,
                      constraints: const BoxConstraints(maxWidth: 1200),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: const FeaturedProjectsSection(),
                    ),
                  ),

                  // Achievements Section
                  ScrollAwareAnimatedSection(
                    scrollController: _scrollController,
                    threshold: 0.15,
                    child: Container(
                      key: _achievementsKey,
                      constraints: const BoxConstraints(maxWidth: 1200),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: const AchievementsSection(),
                    ),
                  ),

                  // Contact Section
                  ScrollAwareAnimatedSection(
                    scrollController: _scrollController,
                    threshold: 0.15,
                    child: Container(
                      key: _contactKey,
                      child: const ContactSection(),
                    ),
                  ),

                  // Footer
                  ScrollAwareAnimatedSection(
                    scrollController: _scrollController,
                    threshold: 0.15,
                    child: const Footer(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
