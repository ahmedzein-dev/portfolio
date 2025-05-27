import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) => const CircleAvatar(
    radius: 75,
    backgroundImage: AssetImage('assets/images/ahmed150.png'),
  );

  //     Container(
  //   decoration: BoxDecoration(
  //     gradient: AppStyle.primaryGradient,
  //     borderRadius: BorderRadius.circular(16),
  //   ),
  //   padding: const EdgeInsets.all(25),
  //   child: const Center(
  //     child: CircleAvatar(
  //       radius: 60,
  //       backgroundImage: AssetImage('assets/images/ahmed120.png'),
  //     ),
  //   ),
  // );
}
