import 'package:ahmed_portfolio/utils/functions.dart';
import 'package:ahmed_portfolio/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 40),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const ProfileCard(), // Your image/profile widget
        const SizedBox(height: 20),

        const Text(
          'Ahmed Zein Elabedin',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2C3E50),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const Text(
          'Mobile Application Developer',
          style: TextStyle(fontSize: 20, color: Color(0xFF7F8C8D)),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        const Text(
          'ahmed.zein1896@gmail.com\n+971 54 462 6234',
          style: TextStyle(fontSize: 16, color: Color(0xFF95A5A6)),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 30),

        Wrap(
          spacing: 15,
          runSpacing: 15,
          alignment: WrapAlignment.center,
          children: [
            SizedBox(
              width: 160,
              child: CustomButton(
                text: 'Follow',
                backgroundColor: const Color(0xFF2C3E50),
                textColor: Colors.white,
                onPressed: () {
                  openUrl(
                    'https://www.linkedin.com/in/ahmed-zein-294230270',
                    mode: LaunchMode.externalApplication,
                  );
                },
              ),
            ),
            SizedBox(
              width: 160,
              child: CustomButton(
                text: 'Message',
                backgroundColor: Colors.transparent,
                textColor: const Color(0xFF2C3E50),
                borderColor: const Color(0xFF2C3E50),
                onPressed: () {
                  openUrl(
                    'https://wa.me/971544626234',
                    mode: LaunchMode.externalApplication,
                  );
                },
              ),
            ),
            SizedBox(
              width: 160,
              child: CustomButton(
                text: 'Send Email',
                backgroundColor: Colors.transparent,
                textColor: const Color(0xFF2C3E50),
                borderColor: const Color(0xFF2C3E50),
                onPressed: () {
                  final Uri emailUri = Uri(
                    scheme: 'mailto',
                    path: 'ahmed.zein1896@gmail.com',
                    query: 'subject=Portfolio Contact&body=Hello Ahmed,',
                  );
                  openUrl(
                    emailUri.toString(),
                    mode: LaunchMode.externalApplication,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
    this.onPressed,
  });

  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton(
    style: OutlinedButton.styleFrom(
      backgroundColor: backgroundColor,
      side:
          borderColor != null
              ? BorderSide(color: borderColor!, width: 2)
              : BorderSide.none,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    ),
    onPressed: onPressed ?? () {},
    child: Text(text, style: TextStyle(fontSize: 16, color: textColor)),
  );
}
