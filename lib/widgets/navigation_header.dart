import 'package:flutter/material.dart';

class NavigationHeader extends StatelessWidget {
  const NavigationHeader({
    super.key,
    this.onAboutTap,
    this.onServicesTap,
    this.onProjectsTap,
    this.onContactTap,
    this.onThemeToggle,
    this.isDarkMode = true,
  });

  final VoidCallback? onAboutTap;
  final VoidCallback? onServicesTap;
  final VoidCallback? onProjectsTap;
  final VoidCallback? onContactTap;
  final VoidCallback? onThemeToggle;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFD4AA7D).withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo/Name - Flexible to prevent overflow
              Flexible(
                child: Text(
                  'Ahmed Zein Elabedin',
                  style: TextStyle(
                    fontSize: isMobile ? 16 : 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Navigation Links or Menu Icon
              if (!isMobile)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildNavLink('About', onAboutTap ?? () {}),
                    const SizedBox(width: 24),
                    _buildNavLink('Services', onServicesTap ?? () {}),
                    const SizedBox(width: 24),
                    _buildNavLink('Projects', onProjectsTap ?? () {}),
                    const SizedBox(width: 24),
                    _buildContactButton(onContactTap ?? () {}),
                  ],
                )
              else
                IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    _showMobileMenu(context);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavLink(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFFCBD5E1),
          ),
        ),
      ),
    );
  }

  Widget _buildContactButton(VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFD4AA7D),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
      child: const Text(
        'Contact',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0F172A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              _buildMobileNavItem('About', Icons.person_outline, () {
                Navigator.pop(context);
                onAboutTap?.call();
              }),
              _buildMobileNavItem(
                'Services',
                Icons.design_services_outlined,
                () {
                  Navigator.pop(context);
                  onServicesTap?.call();
                },
              ),
              _buildMobileNavItem('Projects', Icons.work_outline, () {
                Navigator.pop(context);
                onProjectsTap?.call();
              }),
              _buildMobileNavItem('Contact', Icons.mail_outline, () {
                Navigator.pop(context);
                onContactTap?.call();
              }),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMobileNavItem(String text, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFD4AA7D)),
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
