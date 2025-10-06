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
          onTap: () {
            // TODO: Open privacy policy
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Privacy policy coming soon')),
            );
          },
        ),
        const Divider(),
        ListTile(
          title: const Text('Terms of Service'),
          leading: const Icon(Icons.description),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            // TODO: Open terms of service
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Terms of service coming soon')),
            );
          },
        ),
        const Divider(),
        ListTile(
          title: const Text('Contact Support'),
          leading: const Icon(Icons.support),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            // TODO: Open contact support
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Contact support coming soon')),
            );
          },
        ),
      ],
    );
  }
}