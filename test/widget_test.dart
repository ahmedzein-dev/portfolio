import 'package:flutter/material.dart';

void main() => runApp(const MyPortfolioApp());

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Ahmed Zein Elabedin Portfolio',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'Poppins', brightness: Brightness.light),
    home: const PortfolioPage(),
  );
}

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF9FAFB),
    body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                const Text(
                  'Ahmed Zein Elabedin',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const Text(
                  'Mobile App Developer | Flutter Expert',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('View Resume'),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text('Contact Me'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/ahmed120.png'),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  'Highly skilled mobile app developer with 5+ years of experience specializing in cross-platform Flutter development. Built apps including BA3 Business Solution, RAK Rent, and Gainz AI with seamless UI/UX and performance optimization.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          const Text(
            'Projects',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              projectCard(
                'RAK Rent',
                'Real-estate rentals in UAE.',
                'assets/images/rak_rent.png',
              ),
              projectCard(
                'Gainz AI',
                'AI fitness assistant app.',
                'assets/images/gainz_ai.png',
              ),
              projectCard(
                'Spark Gym',
                'Personalized group training.',
                'assets/images/spark_gym.png',
              ),
              projectCard(
                'Vision School',
                'School management system.',
                'assets/images/vision_school.png',
              ),
            ],
          ),
          const SizedBox(height: 40),
          const Text(
            'Tech Stack',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 20,
            children: [
              techIcon('assets/icons/flutter.png'),
              techIcon('assets/icons/dart.png'),
              techIcon('assets/icons/firebase.png'),
              techIcon('assets/icons/mysql.png'),
            ],
          ),
          const SizedBox(height: 40),
          const Text(
            'Certifications',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            '• Stanford Algorithms Specialization\n• Udacity Million Arab Coders\n• OOP in Java – UC San Diego\n• Algorithms Analysis and Design',
          ),
          const SizedBox(height: 40),
          const Text(
            'Contact',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text('📧 ahmed.zein1896@gmail.com'),
          const Text('📞 +971544626234'),
          const Text('🔗 GitHub / LinkedIn'),
        ],
      ),
    ),
  );

  Widget projectCard(
    String title,
    String description,
    String imagePath,
  ) => SizedBox(
    width: 300,
    child: Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(imagePath, height: 150, fit: BoxFit.cover),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(description),
            const SizedBox(height: 10),
            Row(
              children: [
                OutlinedButton(onPressed: () {}, child: const Text('GitHub')),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Live Demo'),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );

  Widget techIcon(String iconPath) =>
      Image.asset(iconPath, width: 40, height: 40);
}
