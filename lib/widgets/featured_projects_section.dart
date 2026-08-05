import 'package:ahmed_portfolio/data/project_repository.dart';

import 'package:ahmed_portfolio/utils/functions.dart';
import 'package:ahmed_portfolio/widgets/hover_card.dart';
import 'package:ahmed_portfolio/widgets/projects_section_card.dart';
import 'package:flutter/material.dart';

class FeaturedProjectsSection extends StatelessWidget {
  const FeaturedProjectsSection({super.key});

  void _showAllProjects(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(20),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200, maxHeight: 800),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFFD4AA7D).withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: const Color(0xFFD4AA7D).withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'All Projects',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(24),
                      child: ProjectsSection(),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'PORTFOLIO',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFFD4AA7D),
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Featured Projects',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'A showcase of my recent work and the technologies I use to create amazing mobile experiences',
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
              final featuredProjects =
                  LocalProjectRepository()
                      .getProjects()
                      .where((p) => p.isFeatured)
                      .toList();

              return Column(
                children:
                    featuredProjects.asMap().entries.map((entry) {
                      final index = entry.key;
                      final project = entry.value;
                      return Column(
                        children: [
                          _buildFeaturedProject(
                            context: context,
                            constraints: constraints,
                            category: project.category,
                            year: project.year,
                            company: project.company,
                            title: project.title,
                            description: project.description,
                            technologies: project.technologies,
                            url: project.url,
                            playStoreUrl: project.playStoreUrl,
                            appStoreUrl: project.appStoreUrl,
                            imagePath: project.imagePath,
                            isReversed: index % 2 != 0,
                          ),
                          if (index != featuredProjects.length - 1)
                            const SizedBox(height: 60),
                        ],
                      );
                    }).toList(),
              );
            },
          ),
          const SizedBox(height: 40),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFD4AA7D),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: const Text(
              'Interested in seeing more of my work?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () => _showAllProjects(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFD4AA7D),
              side: const BorderSide(color: Color(0xFFD4AA7D), width: 2),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'View All Projects',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedProject({
    required BuildContext context,
    required BoxConstraints constraints,
    required String category,
    required String year,
    required String company,
    required String title,
    required String description,
    required List<String> technologies,
    required String url,
    required String playStoreUrl,
    required String appStoreUrl,
    required String imagePath,
    bool isReversed = false,
  }) {
    final isDesktop = constraints.maxWidth > 900;
    final shouldReverse = isDesktop && isReversed;

    final Widget imageWidget = HoverCard(
      child: Container(
        height: isDesktop ? 550 : 350,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFD4AA7D).withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFD4AA7D).withValues(alpha: 0.1),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: const Color(0xFF1E293B),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image_outlined,
                        size: 60,
                        color: const Color(0xFFD4AA7D).withValues(alpha: 0.5),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );

    final List<Widget> storeButtons = _buildStoreButtons(
      appStoreUrl: appStoreUrl,
      playStoreUrl: playStoreUrl,
      fallbackUrl: url,
    );

    final Widget contentWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category and Year
        Wrap(
          spacing: 12,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFD4AA7D).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                category,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFD4AA7D),
                ),
              ),
            ),
            Text(
              year,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF9CA3AF),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Company
        Row(
          children: [
            const Icon(Icons.business, size: 16, color: Color(0xFF9CA3AF)),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                'Associated with $company',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF9CA3AF),
                  fontWeight: FontWeight.w400,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Title
        Text(
          title,
          style: TextStyle(
            fontSize: isDesktop ? 36 : 28,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        // Description
        Text(
          description,
          style: TextStyle(
            fontSize: isDesktop ? 18 : 16,
            color: const Color(0xFF9CA3AF),
            height: 1.7,
          ),
        ),
        const SizedBox(height: 24),
        // Technologies
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children:
              technologies.map((tech) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFFD4AA7D).withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    tech,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFD4AA7D),
                    ),
                  ),
                );
              }).toList(),
        ),
        const SizedBox(height: 28),
        // Store links (falls back to a generic "View Project" button)
        if (storeButtons.isNotEmpty)
          isDesktop
              ? Wrap(spacing: 12, runSpacing: 12, children: storeButtons)
              : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _withVerticalGaps(storeButtons),
              ),
      ],
    );

    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        textDirection: shouldReverse ? TextDirection.rtl : TextDirection.ltr,
        children: [
          Expanded(flex: 1, child: imageWidget),
          const SizedBox(width: 50),
          Expanded(flex: 1, child: contentWidget),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [imageWidget, const SizedBox(height: 24), contentWidget],
      );
    }
  }

  /// Builds one button per available store. When a project has no store
  /// links at all, falls back to a single generic "View Project" button so
  /// non-published projects still get a call to action.
  List<Widget> _buildStoreButtons({
    required String appStoreUrl,
    required String playStoreUrl,
    required String fallbackUrl,
  }) {
    final buttons = <Widget>[];
    if (appStoreUrl.isNotEmpty) {
      buttons.add(_storeButton('App Store', Icons.apple, appStoreUrl));
    }
    if (playStoreUrl.isNotEmpty) {
      buttons.add(_storeButton('Google Play', Icons.android, playStoreUrl));
    }
    if (buttons.isEmpty && fallbackUrl.isNotEmpty) {
      buttons.add(
        _storeButton('View Project', Icons.open_in_new, fallbackUrl),
      );
    }
    return buttons;
  }

  Widget _storeButton(String label, IconData icon, String url) {
    return OutlinedButton.icon(
      onPressed: () => openUrl(url),
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFFD4AA7D),
        side: const BorderSide(color: Color(0xFFD4AA7D), width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  List<Widget> _withVerticalGaps(List<Widget> children) {
    final out = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      if (i > 0) out.add(const SizedBox(height: 12));
      out.add(children[i]);
    }
    return out;
  }
}
