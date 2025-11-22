import 'dart:convert';
import 'dart:developer';

import 'package:ahmed_portfolio/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../utils/email_constants.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isLoading = false;

  // EmailJS Configuration
  static const String _serviceId = EmailConstants.serviceId;
  static const String _templateId = EmailConstants.templateId; // Get this from EmailJS
  static const String _publicKey = EmailConstants.publicKey; // Get this from EmailJS Account > API Keys

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final now = DateTime.now();
      final formattedTime = '${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute.toString().padLeft(2, '0')}';

      final response = await http.post(
        Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'service_id': _serviceId,
          'template_id': _templateId,
          'user_id': _publicKey,
          'template_params': {
            'name': _nameController.text,
            'email': _emailController.text,
            'title': _subjectController.text, // matches {{title}} in Subject line
            'subject': _subjectController.text, // matches {{subject}} in content
            'message': _messageController.text,
            'time': formattedTime,
          },
        }),
      );

      if (response.statusCode == 200) {
        _showSnackBar('Message sent successfully! I\'ll get back to you soon.', isSuccess: true);
        _clearForm();
      } else {
        log('Error in _sendEmail ${response.statusCode} ${response.body}');
        _showSnackBar('Failed to send message. Please try again or email me directly.');
      }
    } catch (e) {
      log('Error in _sendEmail: $e');
      _showSnackBar('Error: Please check your connection or email me directly.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message, {bool isSuccess = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? const Color(0xFF10B981) : Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _clearForm() {
    _nameController.clear();
    _emailController.clear();
    _subjectController.clear();
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Let's Build Something Amazing Together",
                        style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800, color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "I'm currently available for freelance projects and full-time opportunities. Let's discuss how we can bring your mobile app ideas to life.",
                        style: TextStyle(fontSize: 18, color: Color(0xFF9CA3AF), height: 1.6),
                      ),
                      const SizedBox(height: 40),
                      _buildContactInfo(),
                    ],
                  ),
                ),
                const SizedBox(width: 60),
                Expanded(flex: 1, child: _buildContactForm()),
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Let's Build Something Amazing Together",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: Colors.white),
                ),
                const SizedBox(height: 16),
                const Text(
                  "I'm currently available for freelance projects and full-time opportunities. Let's discuss how we can bring your mobile app ideas to life.",
                  style: TextStyle(fontSize: 16, color: Color(0xFF9CA3AF), height: 1.6),
                ),
                const SizedBox(height: 40),
                _buildContactInfo(),
                const SizedBox(height: 40),
                _buildContactForm(),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildContactItem(
          icon: Icons.email,
          title: 'Email Me',
          content: 'ahmed.zein1896@gmail.com',
          onTap: () {
            final Uri emailUri = Uri(
              scheme: 'mailto',
              path: 'ahmed.zein1896@gmail.com',
              query: 'subject=Portfolio Contact&body=Hello Ahmed,',
            );
            openUrl(emailUri.toString(), mode: LaunchMode.externalApplication);
          },
        ),
        const SizedBox(height: 24),
        _buildContactItem(
          icon: Icons.link,
          title: 'LinkedIn',
          content: 'Connect with me',
          onTap:
              () => openUrl('https://www.linkedin.com/in/ahmed-zein-294230270', mode: LaunchMode.externalApplication),
        ),
        const SizedBox(height: 24),
        _buildContactItem(
          icon: Icons.code,
          title: 'GitHub',
          content: 'View my code',
          onTap: () => openUrl('https://github.com/ahmedzein-dev', mode: LaunchMode.externalApplication),
        ),
      ],
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String content,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xFF10B981)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                  const SizedBox(height: 4),
                  Text(content, style: const TextStyle(fontSize: 14, color: Color(0xFF9CA3AF))),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFF9CA3AF)),
          ],
        ),
      ),
    );
  }

  Widget _buildContactForm() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF10B981).withOpacity(0.2), width: 1),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(color: Color(0xFF10B981), shape: BoxShape.circle),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Available for new projects',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildTextField(
              label: 'Name',
              hint: 'Your name',
              controller: _nameController,
              validator: (v) => v!.isEmpty ? 'Please enter your name' : null,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              label: 'Email',
              hint: 'your.email@example.com',
              controller: _emailController,
              validator: (v) {
                if (v!.isEmpty) return 'Please enter your email';
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v)) return 'Please enter a valid email';
                return null;
              },
            ),
            const SizedBox(height: 20),
            _buildTextField(
              label: 'Subject',
              hint: 'Project inquiry',
              controller: _subjectController,
              validator: (v) => v!.isEmpty ? 'Please enter a subject' : null,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              label: 'Message',
              hint: 'Tell me about your project...',
              maxLines: 5,
              controller: _messageController,
              validator: (v) => v!.isEmpty ? 'Please enter your message' : null,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _sendEmail,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: const Color(0xFF10B981).withOpacity(0.5),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child:
                    _isLoading
                        ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                        : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.send, size: 18),
                            SizedBox(width: 8),
                            Text('Send Message', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          ],
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFFCBD5E1))),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFF64748B)),
            filled: true,
            fillColor: const Color(0xFF0F172A),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: const Color(0xFF10B981).withOpacity(0.3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: const Color(0xFF10B981).withOpacity(0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF10B981), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }
}
