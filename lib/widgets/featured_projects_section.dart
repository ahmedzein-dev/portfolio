import 'package:ahmed_portfolio/utils/functions.dart';
import 'package:ahmed_portfolio/widgets/projects_section_card.dart';
import 'package:flutter/material.dart';

class FeaturedProjectsSection extends StatelessWidget {
  const FeaturedProjectsSection({super.key});

  void _showAllProjects(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200, maxHeight: 800),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF10B981).withOpacity(0.3), width: 1),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: const Color(0xFF10B981).withOpacity(0.2), width: 1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('All Projects', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: Colors.white)),
                    IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: () => Navigator.of(context).pop()),
                  ],
                ),
              ),
              const Expanded(child: SingleChildScrollView(padding: EdgeInsets.all(24), child: ProjectsSection())),
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
          const Text('PORTFOLIO', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF10B981), letterSpacing: 2)),
          const SizedBox(height: 16),
          const Text('Featured Projects', style: TextStyle(fontSize: 48, fontWeight: FontWeight.w800, color: Colors.white)),
          const SizedBox(height: 12),
          const Text(
            'A showcase of my recent work and the technologies I use to create amazing mobile experiences',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Color(0xFF9CA3AF), height: 1.6),
          ),
          const SizedBox(height: 60),
          LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  _buildFeaturedProject(
                    context: context,
                    constraints: constraints,
                    category: 'E-Commerce & Gifting',
                    year: 'Apr 2025 - Present',
                    company: 'Kief Consultancy & Technology',
                    title: 'The Events',
                    description:
                    'Events is the leading online flowers and gifting company in the United Arab Emirates and Arabian Gulf. Our company was founded in 2022, and within three years we expanded our operations to include nine countries. At Events, we pride ourselves on creating a seamless and innovative experience for our customers and we love making the process of sending flowers and gifts as enjoyable as receiving them. We make sure to source our products daily from the best ethical vendors, artists and celebrities around the world to create an amazing experience that fits every occasion.',
                    technologies: [
                      'Flutter',
                      'Dart',
                      'REST APIs',
                      'Payment Gateways',
                      'Google Pay & Apple Pay',
                      'Forced app updates',
                      'Hive',
                      'State Management',
                      'Pagination',
                      'Error Handling',
                      'HTML Rendering',
                      'Telr',
                      'PDF & Print',
                      'Unit Testing',
                      'Secure Storage',
                      'Dependency Injection',
                    ],
                    url: 'https://apps.apple.com/in/app/the-events/id6739205204',
                    imagePath: 'assets/images/theevents_image.png',
                  ),
                  const SizedBox(height: 60),
                  _buildFeaturedProject(
                    context: context,
                    constraints: constraints,
                    category: 'Health & Fitness',
                    year: 'Feb 2024 - May 2024',
                    company: 'GAINZ.AI',
                    title: 'Gainz AI',
                    description:
                    'Developed a next-gen fitness app featuring hyper-realistic AI athlete avatars and adaptive training plans. Gainz AI delivers real-time coaching, personalized workouts and nutrition, and comprehensive progress tracking—transforming the user\'s fitness journey through intelligent, interactive experiences.',
                    technologies: [
                      'Flutter',
                      'Dart',
                      'AI Integration',
                      'Summarization & Translation',
                      'Package Development',
                      'Dependency Injection',
                      'Search Optimization',
                    ],
                    url: 'https://apps.apple.com/us/app/gainz-ai-chat-train-track/id6474649083',
                    imagePath: 'assets/images/gainz_image.png',
                    isReversed: true,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 40),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF10B981),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: const Text('Interested in seeing more of my work?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () => _showAllProjects(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF10B981),
              side: const BorderSide(color: Color(0xFF10B981), width: 2),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('View All Projects', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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
    required String imagePath,
    bool isReversed = false,
  }) {
    final isDesktop = constraints.maxWidth > 900;
    final shouldReverse = isDesktop && isReversed;

    final Widget imageWidget = Container(
      height: isDesktop ? 550 : 280,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF10B981).withOpacity(0.2), width: 1),
        boxShadow: [
          BoxShadow(color: const Color(0xFF10B981).withOpacity(0.1), blurRadius: 30, offset: const Offset(0, 10)),
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
                    Icon(Icons.image_outlined, size: 60, color: const Color(0xFF10B981).withOpacity(0.5)),
                    const SizedBox(height: 12),
                    Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
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
                color: const Color(0xFF10B981).withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(category, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF10B981))),
            ),
            Text(year, style: const TextStyle(fontSize: 14, color: Color(0xFF9CA3AF), fontWeight: FontWeight.w500)),
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
                style: const TextStyle(fontSize: 14, color: Color(0xFF9CA3AF), fontWeight: FontWeight.w400),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Title
        Text(title, style: TextStyle(fontSize: isDesktop ? 36 : 28, fontWeight: FontWeight.w800, color: Colors.white)),
        const SizedBox(height: 16),
        // Description
        Text(description, style: TextStyle(fontSize: isDesktop ? 18 : 16, color: const Color(0xFF9CA3AF), height: 1.7)),
        const SizedBox(height: 24),
        // Technologies
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: technologies.map((tech) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF10B981).withOpacity(0.3), width: 1),
              ),
              child: Text(tech, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF10B981))),
            );
          }).toList(),
        ),
        const SizedBox(height: 28),
        // View Project Button
        if (url.isNotEmpty)
          isDesktop
              ? OutlinedButton.icon(
            onPressed: () => openUrl(url),
            icon: const Icon(Icons.open_in_new, size: 18),
            label: const Text('View Project'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF10B981),
              side: const BorderSide(color: Color(0xFF10B981), width: 2),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          )
              : SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => openUrl(url),
              icon: const Icon(Icons.open_in_new, size: 18),
              label: const Text('View Project'),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF10B981),
                side: const BorderSide(color: Color(0xFF10B981), width: 2),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
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
}