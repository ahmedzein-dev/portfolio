import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

Future<void> openUrl(
  String url, {
  LaunchMode mode = LaunchMode.platformDefault,
}) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: mode);
  } else {
    log('Could not launch $url');
  }
}
