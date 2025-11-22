import 'package:ahmed_portfolio/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenSourceSection extends StatelessWidget {
  const OpenSourceSection({super.key});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 6)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Open Source Contributions',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1B2733),
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 24),
        _buildPackageItem(
          title: 'Scroll Highlight Text',
          description:
              'Highlight and scroll through bilingual text (Latin/Arabic). Ideal for educational or reading apps.',
          url: 'https://pub.dev/packages/scroll_highlight_text',
        ),
        const Divider(height: 40, color: Color(0xFFE0E0E0)),
        _buildPackageItem(
          title: 'Document Camera Frame',
          description:
              'Custom Flutter camera UI with live preview and smart cropping for document scanning.',
          url: 'https://pub.dev/packages/document_camera_frame',
        ),
      ],
    ),
  );

  Widget _buildPackageItem({
    required String title,
    required String description,
    required String url,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF34495E),
        ),
      ),
      const SizedBox(height: 8),
      Text(
        description,
        style: const TextStyle(
          fontSize: 15,
          color: Color(0xFF7F8C8D),
          height: 1.4,
        ),
      ),
      const SizedBox(height: 12),
      ElevatedButton.icon(
        onPressed: () => openUrl(url, mode: LaunchMode.externalApplication),
        icon: const Icon(Icons.open_in_new, size: 18),
        label: const Text('View on pub.dev'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2C3E50),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    ],
  );
}
