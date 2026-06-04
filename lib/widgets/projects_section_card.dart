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
                  isInDevelopment: project.isInDevelopment,
                  screenshotPaths: project.screenshotPaths,
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
  bool isInDevelopment = false,
  List<String> screenshotPaths = const [],
}) => Container(
  decoration: BoxDecoration(
    color: const Color(0xFF1E293B),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
      color: const Color(0xFFD4AA7D).withValues(alpha: 0.2),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageArea(
                screenshotPaths: screenshotPaths,
                icon: icon,
                width: screenshotPaths.length == 1 ? 580 : 420,
                height: screenshotPaths.length == 1 ? 520 : 460,
                borderRadius: BorderRadius.circular(16),
              ),
              Expanded(
                child: _buildProjectContent(
                  title,
                  description,
                  url,
                  features,
                  techTags,
                  isInDevelopment: isInDevelopment,
                ),
              ),
            ],
          ),
        );
      } else {
        return Column(
          children: [
            _buildImageArea(
              screenshotPaths: screenshotPaths,
              icon: icon,
              width: double.infinity,
              height: 420,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
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
                isInDevelopment: isInDevelopment,
              ),
            ),
          ],
        );
      }
    },
  ),
);

Widget _buildImageArea({
  required List<String> screenshotPaths,
  required String icon,
  required double width,
  required double height,
  required BorderRadius borderRadius,
}) {
  if (screenshotPaths.isNotEmpty) {
    final isSingle = screenshotPaths.length == 1;

    if (isSingle) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: Image.asset(
          screenshotPaths.first,
          width: width,
          fit: BoxFit.fitWidth,
        ),
      );
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: borderRadius,
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: screenshotPaths.asMap().entries.map((entry) {
          final index = entry.key;
          final path = entry.value;
          final imageHeight = height - 24;
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: index > 0 ? 10 : 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  path,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: imageHeight,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: const Color(0xFF0F172A),
      borderRadius: borderRadius,
      border: Border.all(
        color: const Color(0xFFD4AA7D).withValues(alpha: 0.2),
        width: 1,
      ),
    ),
    child: Center(
      child: Text(icon, style: const TextStyle(fontSize: 80)),
    ),
  );
}

Widget _buildInDevelopmentBadge() => Container(
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  decoration: BoxDecoration(
    color: const Color(0xFFF97316).withValues(alpha: 0.25),
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: const Color(0xFFF97316).withValues(alpha: 0.6), width: 1),
  ),
  child: const Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.construction_rounded, size: 12, color: Colors.white),
      SizedBox(width: 5),
      Text(
        'In Development',
        style: TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  ),
);

Widget _buildProjectContent(
  String title,
  String description,
  String url,
  List<String> features,
  List<String> techTags, {
  bool isInDevelopment = false,
}) => Column(
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
              Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  if (isInDevelopment) ...[
                    const SizedBox(width: 12),
                    _buildInDevelopmentBadge(),
                  ],
                ],
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
            icon: const Icon(Icons.link, color: Color(0xFFD4AA7D)),
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
                  color: Color(0xFFD4AA7D),
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
                      color: const Color(0xFFD4AA7D).withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(
                      color: Color(0xFFD4AA7D),
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
