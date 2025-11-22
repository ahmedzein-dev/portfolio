import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/functions.dart';

class HoverLinkText extends StatefulWidget {
  const HoverLinkText({super.key, required this.text, required this.url});

  final String text;
  final String url;

  @override
  State<HoverLinkText> createState() => _HoverLinkTextState();
}

class _HoverLinkTextState extends State<HoverLinkText> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => isHovered = true),
    onExit: (_) => setState(() => isHovered = false),
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: () => openUrl(widget.url, mode: LaunchMode.externalApplication),
      child: Text(
        widget.text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: isHovered ? Colors.blue : Colors.black,
          decoration:
              isHovered ? TextDecoration.underline : TextDecoration.none,
        ),
      ),
    ),
  );
}
