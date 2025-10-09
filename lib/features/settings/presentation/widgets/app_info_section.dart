import 'package:flutter/material.dart';

/// Widget for displaying app information
class AppInfoSection extends StatelessWidget {
  const AppInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('App Version'),
          subtitle: const Text('1.0.0'),
          leading: const Icon(Icons.tag),
        ),
        const Divider(),
        ListTile(
          title: const Text('Privacy Policy'),
          leading: const Icon(Icons.privacy_tip),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () => _showPrivacyPolicy(context),
        ),
        const Divider(),
        ListTile(
          title: const Text('Terms of Service'),
          leading: const Icon(Icons.description),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () => _showTermsOfService(context),
        ),
        const Divider(),
        ListTile(
          title: const Text('Contact Support'),
          leading: const Icon(Icons.support),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () => _showContactSupport(context),
        ),
      ],
    );
  }

  void _showPrivacyPolicy(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy Policy'),
        content: const SingleChildScrollView(
          child: Text(
            'Privacy Policy\n\n'
            'This Budget Tracker app respects your privacy. We collect minimal data necessary for the app to function:\n\n'
            '• Transaction data (stored locally on your device)\n'
            '• User preferences and settings\n'
            '• App usage analytics (optional)\n\n'
            'We do not share your personal data with third parties. All data is stored securely on your device.\n\n'
            'For questions about our privacy practices, please contact support.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showTermsOfService(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Terms of Service'),
        content: const SingleChildScrollView(
          child: Text(
            'Terms of Service\n\n'
            'By using this Budget Tracker app, you agree to these terms:\n\n'
            '1. This app is provided "as is" without warranties.\n'
            '2. You are responsible for the accuracy of your financial data.\n'
            '3. The app stores data locally on your device.\n'
            '4. We are not responsible for data loss due to device issues.\n'
            '5. These terms may be updated at any time.\n\n'
            'Continued use of the app constitutes acceptance of these terms.',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showContactSupport(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Contact Support'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Need help? Contact us through:'),
            SizedBox(height: 16),
            Text('• Email: support@budgettracker.com'),
            Text('• Website: www.budgettracker.com/support'),
            Text('• In-app feedback form (Settings > Help)'),
            SizedBox(height: 16),
            Text(
              'For urgent issues, please include your device information and a detailed description of the problem.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}