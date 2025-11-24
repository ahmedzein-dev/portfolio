import 'package:flutter/material.dart';

class AnimatedSection extends StatefulWidget {
  const AnimatedSection({super.key, required this.child, this.delay = 0});

  final Widget child;
  final int delay;

  @override
  State<AnimatedSection> createState() => _AnimatedSectionState();
}

class _AnimatedSectionState extends State<AnimatedSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    // Start checking visibility after a delay
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted && !_hasAnimated) {
        _checkVisibility();
      }
    });
  }

  void _checkVisibility() {
    if (_hasAnimated) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _hasAnimated) return;

      final RenderObject? renderObject = context.findRenderObject();
      if (renderObject == null) return;

      final RenderBox renderBox = renderObject as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);
      final size = renderBox.size;
      final screenHeight = MediaQuery.of(context).size.height;

      // Check if widget is in viewport (with some threshold)
      final isVisible =
          position.dy < screenHeight * 0.8 &&
          position.dy + size.height > -screenHeight * 0.2;

      if (isVisible && !_hasAnimated) {
        setState(() {
          _hasAnimated = true;
        });
        _controller.forward();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasAnimated) {
      _checkVisibility();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: ScaleTransition(scale: _scaleAnimation, child: widget.child),
      ),
    );
  }
}

/// Scroll-aware animated section that triggers when scrolled into view
class ScrollAwareAnimatedSection extends StatefulWidget {
  const ScrollAwareAnimatedSection({
    super.key,
    required this.child,
    this.scrollController,
    this.threshold = 0.2,
  });

  final Widget child;
  final ScrollController? scrollController;
  final double threshold; // Percentage of widget visible before animating

  @override
  State<ScrollAwareAnimatedSection> createState() =>
      _ScrollAwareAnimatedSectionState();
}

class _ScrollAwareAnimatedSectionState extends State<ScrollAwareAnimatedSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  bool _hasAnimated = false;
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.85, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.85, curve: Curves.easeOutCubic),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.92, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.85, curve: Curves.easeOutCubic),
      ),
    );

    widget.scrollController?.addListener(_onScroll);

    // Check initial visibility after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibility();
      // Also check periodically in case initial check misses it
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted && !_hasAnimated) {
          _checkVisibility();
        }
      });
    });
  }

  void _onScroll() {
    if (!_hasAnimated) {
      _checkVisibility();
    }
  }

  void _checkVisibility() {
    if (_hasAnimated || !mounted) return;

    final RenderObject? renderObject = _key.currentContext?.findRenderObject();
    if (renderObject == null) {
      // Retry after a frame if render object is not ready
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && !_hasAnimated) {
          _checkVisibility();
        }
      });
      return;
    }

    final RenderBox renderBox = renderObject as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate if widget is visible in viewport
    // Widget is visible if it's within the viewport with threshold
    final isVisible =
        position.dy < screenHeight * (1 - widget.threshold) &&
        position.dy + size.height > screenHeight * widget.threshold;

    if (isVisible && !_hasAnimated) {
      setState(() {
        _hasAnimated = true;
      });
      _controller.forward();
    }
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: ScaleTransition(scale: _scaleAnimation, child: widget.child),
        ),
      ),
    );
  }
}
