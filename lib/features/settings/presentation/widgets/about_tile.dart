import 'package:flutter/material.dart';

/// Settings tile for about and app information
class AboutTile extends StatelessWidget {
  const AboutTile({
    super.key,
    required this.appVersion,
    required this.onRateApp,
    required this.onContactSupport,
    required this.onPrivacyPolicy,
    required this.onTermsOfService,
  });

  final String appVersion;
  final VoidCallback onRateApp;
  final VoidCallback onContactSupport;
  final VoidCallback onPrivacyPolicy;
  final VoidCallback onTermsOfService;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('App Version'),
          subtitle: Text(appVersion),
        ),
        const Divider(height: 1),
        ListTile(
          leading: const Icon(Icons.star),
          title: const Text('Rate App'),
          subtitle: const Text('Leave a review on the app store'),
          trailing: const Icon(Icons.chevron_right),
          onTap: onRateApp,
        ),
        const Divider(height: 1),
        ListTile(
          leading: const Icon(Icons.support),
          title: const Text('Contact Support'),
          subtitle: const Text('Get help or report issues'),
          trailing: const Icon(Icons.chevron_right),
          onTap: onContactSupport,
        ),
        const Divider(height: 1),
        ListTile(
          leading: const Icon(Icons.privacy_tip),
          title: const Text('Privacy Policy'),
          subtitle: const Text('How we protect your data'),
          trailing: const Icon(Icons.chevron_right),
          onTap: onPrivacyPolicy,
        ),
        const Divider(height: 1),
        ListTile(
          leading: const Icon(Icons.description),
          title: const Text('Terms of Service'),
          subtitle: const Text('Terms and conditions'),
          trailing: const Icon(Icons.chevron_right),
          onTap: onTermsOfService,
        ),
      ],
    );
  }
}