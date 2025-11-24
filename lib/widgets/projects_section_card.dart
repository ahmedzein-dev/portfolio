import 'package:ahmed_portfolio/data/project_repository.dart';
import 'package:flutter/material.dart';

import '../utils/functions.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projects =
        LocalProjectRepository()
            .getProjects()
            .where((p) => !p.isFeatured)
            .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          projects.asMap().entries.map((entry) {
            final index = entry.key;
            final project = entry.value;
            return Column(
              children: [
                if (index > 0) const SizedBox(height: 30),
                _buildProjectCard(
                  title: project.title,
                  description: project.description,
                  features: project.features,
                  techTags: project.technologies,
                  icon: project.icon,
                  url: project.url,
                ),
              ],
            );
          }).toList(),
    );
  }
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
    color: const Color(0xFF1E293B),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
      color: const Color(0xFF10B981).withValues(alpha: 0.2),
      width: 1,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.3),
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
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  border: Border.all(
                    color: const Color(0xFF10B981).withValues(alpha: 0.2),
                    width: 1,
                  ),
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
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                border: Border(
                  bottom: BorderSide(
                    color: const Color(0xFF10B981).withValues(alpha: 0.2),
                    width: 1,
                  ),
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
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 16),
              ),
            ],
          ),
        ),
        if (url.isNotEmpty)
          IconButton(
            onPressed: () {
              openUrl(url);
            },
            icon: const Icon(Icons.link, color: Color(0xFF10B981)),
            tooltip: 'App Link',
          ),
      ],
    ),
    if (features.isNotEmpty) ...[
      const SizedBox(height: 20),
      const Text(
        'Key Features:',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
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
                  color: Color(0xFF10B981),
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Text(
                  feature,
                  style: const TextStyle(
                    color: Color(0xFFCBD5E1),
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
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
                    color: const Color(0xFF0F172A),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF10B981).withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(
                      color: Color(0xFF10B981),
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
