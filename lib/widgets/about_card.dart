import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AboutCard extends StatefulWidget {
  const AboutCard({super.key, this.onWorkTogether, this.onViewWork});

  final VoidCallback? onWorkTogether;
  final VoidCallback? onViewWork;

  @override
  State<AboutCard> createState() => _AboutCardState();
}

class _AboutCardState extends State<AboutCard> with TickerProviderStateMixin {
  // Image animations
  late AnimationController _imageController;
  late Animation<double> _imageFadeAnimation;
  late Animation<double> _imageRotateAnimation;
  late Animation<Offset> _imageSlideAnimation;

  // Badge animations
  late AnimationController _badgeController;
  late Animation<double> _badgeFadeAnimation;
  late Animation<double> _badgeRotateAnimation;
  late Animation<double> _badgeScaleAnimation;

  bool _hasImageAnimated = false;
  bool _hasBadgeAnimated = false;

  @override
  void initState() {
    super.initState();

    // Image animation controller - smoother with longer duration
    _imageController = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    );

    // Badge animation controller
    _badgeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Image animations
    _imageFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _imageController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _imageRotateAnimation = Tween<double>(begin: -0.12, end: 0.0).animate(
      CurvedAnimation(
        parent: _imageController,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _imageSlideAnimation = Tween<Offset>(
      begin: const Offset(-0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _imageController,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic),
    ));

    // Badge animations - gift card style
    _badgeFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _badgeController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    // Rotate from right (positive) -> overshoot left (negative) -> settle at 0
    _badgeRotateAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.3, end: -0.08)
            .chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 60,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: -0.08, end: 0.0)
            .chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 40,
      ),
    ]).animate(_badgeController);

    _badgeScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.5, end: 1.05)
            .chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 70,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.05, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 30,
      ),
    ]).animate(_badgeController);


  }

  void _startImageAnimation() {
    if (!_hasImageAnimated) {
      _hasImageAnimated = true;
      _imageController.forward();
    }
  }

  void _startBadgeAnimation() {
    if (!_hasBadgeAnimated && _hasImageAnimated) {
      _hasBadgeAnimated = true;
      _badgeController.forward();
    }
  }

  @override
  void dispose() {
    _imageController.dispose();
    _badgeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('about-card-visibility'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3) {
          _startImageAnimation();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 900) {
              return _buildDesktopLayout();
            } else {
              return _buildMobileLayout();
            }
          },
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ABOUT ME',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF10B981),
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Mobile Developer && Design Lover',
                style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 40),
              _buildAnimatedImage(width: double.infinity, height: 480),
            ],
          ),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'About Ahmed Zein Elabedin',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.white),
              ),
              const SizedBox(height: 16),
              _buildStatRow(),
              const SizedBox(height: 24),
              const Text(
                'With over five years of dedicated experience in mobile development, I specialize in using Flutter to bring innovative ideas to life.',
                style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 18, height: 1.7, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 16),
              const Text(
                'My focus is on writing clean, efficient code and designing user interfaces that are both intuitive and visually appealing. I\'m committed to continuous learning and always stay updated with the latest industry trends to deliver modern and scalable solutions.',
                style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 18, height: 1.7, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 32),
              _buildSkillsGrid(),
              const SizedBox(height: 32),
              _buildDesktopButtons(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'ABOUT ME',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF10B981), letterSpacing: 2),
        ),
        const SizedBox(height: 16),
        const Text(
          'Mobile Developer && Design Lover',
          style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.w800),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        _buildAnimatedImage(width: 300, height: 400),
        const SizedBox(height: 32),
        const Text(
          'About Ahmed Zein Elabedin',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        const SizedBox(height: 16),
        _buildStatRow(),
        const SizedBox(height: 24),
        const Text(
          'With over five years of dedicated experience in mobile development, I specialize in using Flutter to bring innovative ideas to life.',
          style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 16, height: 1.7, fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        const Text(
          'My focus is on writing clean, efficient code and designing user interfaces that are both intuitive and visually appealing. I\'m committed to continuous learning and always stay updated with the latest industry trends to deliver modern and scalable solutions.',
          style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 16, height: 1.7, fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        _buildSkillsGrid(),
        const SizedBox(height: 32),
        _buildMobileButtons(),
      ],
    );
  }

  Widget _buildAnimatedImage({required double width, required double height}) {
    return AnimatedBuilder(
      animation: _imageController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _imageFadeAnimation,
          child: SlideTransition(
            position: _imageSlideAnimation,
            child: Transform.rotate(
              angle: _imageRotateAnimation.value,
              alignment: Alignment.bottomCenter,
              child: _buildImageWithBadge(width: width, height: height),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageWithBadge({required double width, required double height}) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Main Image
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.3), width: 1),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/about600.png', fit: BoxFit.cover),
          ),
        ),
        // Animated Experience Badge - Bottom Left with VisibilityDetector
        Positioned(
          bottom: -25,
          left: -15,
          child: VisibilityDetector(
            key: const Key('badge-visibility'),
            onVisibilityChanged: (info) {
              if (info.visibleFraction > 0.1) {
                _startBadgeAnimation();
              }
            },
            child: AnimatedBuilder(
              animation: _badgeController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _badgeFadeAnimation,
                  child: Transform.scale(
                    scale: _badgeScaleAnimation.value,
                    child: Transform.rotate(
                      angle: _badgeRotateAnimation.value,
                      alignment: Alignment.center,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF00F2A0),
                              Color(0xFF00D6A9),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '5+',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF0F172A),
                                height: 1,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Years Experience',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopButtons() {
    return Row(
      children: [
        ElevatedButton(
          onPressed: widget.onWorkTogether,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF10B981),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 0,
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Let's Work Together", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward, size: 18),
            ],
          ),
        ),
        const SizedBox(width: 16),
        OutlinedButton(
          onPressed: widget.onViewWork,
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF10B981),
            side: const BorderSide(color: Color(0xFF10B981), width: 2),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('View My Work', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              SizedBox(width: 8),
              Icon(Icons.circle, size: 12),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: widget.onWorkTogether,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Let's Work Together", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, size: 18),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: widget.onViewWork,
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF10B981),
              side: const BorderSide(color: Color(0xFF10B981), width: 2),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('View My Work', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                SizedBox(width: 8),
                Icon(Icons.circle, size: 12),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF10B981).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.3), width: 1),
          ),
          child: const Text(
            '5+ Years Experience',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF10B981)),
          ),
        ),
      ],
    );
  }

  Widget _buildSkillsGrid() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: [
        _buildSkillChip('Flutter Development'),
        _buildSkillChip('Cross-Platform Apps'),
        _buildSkillChip('UI/UX Design'),
        _buildSkillChip('API Integration'),
      ],
    );
  }

  Widget _buildSkillChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.3), width: 1),
      ),
      child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF10B981))),
    );
  }
}
