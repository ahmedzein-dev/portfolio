class EmailConstants {
  // The const will be replaced at compile time
  static const String serviceId = String.fromEnvironment('EMAILJS_SERVICE_ID');
  static const String templateId = String.fromEnvironment('EMAILJS_TEMPLATE_ID');
  static const String publicKey = String.fromEnvironment('EMAILJS_PUBLIC_KEY');
}
