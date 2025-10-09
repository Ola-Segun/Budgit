import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';

/// Help Center screen with FAQs, contact support, and feedback
class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final List<FAQItem> _faqs = [
    FAQItem(
      question: 'How do I add a new transaction?',
      answer: 'Tap the "+" button on the home screen or transaction list. Fill in the amount, category, and description, then save.',
    ),
    FAQItem(
      question: 'How do I create a budget?',
      answer: 'Go to the Budgets tab, tap "Add Budget", select a category, set your budget amount and time period.',
    ),
    FAQItem(
      question: 'How do I track my goals?',
      answer: 'Navigate to the Goals tab, create a new goal with target amount and deadline. Add contributions regularly to track progress.',
    ),
    FAQItem(
      question: 'How do I manage my accounts?',
      answer: 'Go to More > Accounts to view, add, or edit your bank accounts and cards.',
    ),
    FAQItem(
      question: 'How do I scan receipts?',
      answer: 'Tap the camera button on the home screen or use "Scan Receipt" from quick actions to automatically extract transaction data.',
    ),
    FAQItem(
      question: 'How do I view spending insights?',
      answer: 'Check the Insights section on the home screen or visit More > Insights for detailed spending analysis.',
    ),
    FAQItem(
      question: 'How do I export my data?',
      answer: 'Go to Settings > Data Management to export transactions, budgets, or goals as CSV or PDF files.',
    ),
    FAQItem(
      question: 'How do I set up bill reminders?',
      answer: 'Add recurring bills in the Bills section. Set due dates and amounts to receive timely reminders.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: ListView(
        padding: AppTheme.screenPaddingAll,
        children: [
          // Quick Actions
          _buildQuickActions(context),
          const SizedBox(height: 24),

          // Frequently Asked Questions
          _buildFAQSection(context),
          const SizedBox(height: 24),

          // Contact Support
          _buildContactSupport(context),
          const SizedBox(height: 24),

          // App Information
          _buildAppInfo(context),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Card(
      child: Padding(
        padding: AppSpacing.cardPaddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Help',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _QuickActionButton(
                    icon: Icons.help_outline,
                    label: 'User Guide',
                    onPressed: () => _showUserGuide(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _QuickActionButton(
                    icon: Icons.feedback,
                    label: 'Send Feedback',
                    onPressed: () => _showFeedbackSheet(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _QuickActionButton(
                    icon: Icons.bug_report,
                    label: 'Report Issue',
                    onPressed: () => _showReportIssueSheet(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _QuickActionButton(
                    icon: Icons.chat,
                    label: 'Live Chat',
                    onPressed: () => _startLiveChat(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: AppSpacing.cardPaddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Frequently Asked Questions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 16),
            ..._faqs.map((faq) => _buildFAQItem(context, faq)),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(BuildContext context, FAQItem faq) {
    return ExpansionTile(
      title: Text(
        faq.question,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            faq.answer,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }

  Widget _buildContactSupport(BuildContext context) {
    return Card(
      child: Padding(
        padding: AppSpacing.cardPaddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Support',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 16),
            _buildContactOption(
              context,
              icon: Icons.email,
              title: 'Email Support',
              subtitle: 'support@budgettracker.com',
              onTap: () => _sendEmail(),
            ),
            const Divider(),
            _buildContactOption(
              context,
              icon: Icons.phone,
              title: 'Phone Support',
              subtitle: '+1 (555) 123-4567',
              onTap: () => _makePhoneCall(),
            ),
            const Divider(),
            _buildContactOption(
              context,
              icon: Icons.forum,
              title: 'Community Forum',
              subtitle: 'Get help from other users',
              onTap: () => _openForum(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildAppInfo(BuildContext context) {
    return Card(
      child: Padding(
        padding: AppSpacing.cardPaddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Budget Tracker',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Version', '1.0.0'),
            _buildInfoRow('Last Updated', 'October 2024'),
            const SizedBox(height: 16),
            Text(
              'Terms of Service',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Privacy Policy',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }

  void _showUserGuide(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('User Guide'),
        content: const Text(
          'A comprehensive user guide is coming soon! In the meantime, '
          'explore the app and use the FAQ section above for help.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showFeedbackSheet(BuildContext context) {
    AppBottomSheet.show(
      context: context,
      child: _FeedbackSheet(),
    );
  }

  void _showReportIssueSheet(BuildContext context) {
    AppBottomSheet.show(
      context: context,
      child: _ReportIssueSheet(),
    );
  }

  void _startLiveChat(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Live Chat'),
        content: const Text(
          'Live chat support is currently unavailable. Please use email support or check back later.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _sendEmail() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Email Support'),
        content: const Text(
          'Email support is not yet implemented. Please check back later or use the feedback form.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _makePhoneCall() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Phone Support'),
        content: const Text(
          'Phone support is not yet available. Please use email support or the feedback form.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _openForum() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Community Forum'),
        content: const Text(
          'Community forum is coming soon! In the meantime, use the feedback form to share your thoughts.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: Theme.of(context).primaryColor,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class FAQItem {
  const FAQItem({
    required this.question,
    required this.answer,
  });

  final String question;
  final String answer;
}

class _FeedbackSheet extends StatefulWidget {
  @override
  State<_FeedbackSheet> createState() => _FeedbackSheetState();
}

class _FeedbackSheetState extends State<_FeedbackSheet> {
  final _controller = TextEditingController();
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Send Feedback',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Text(
            'How would you rate your experience?',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < _rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
                onPressed: () => setState(() => _rating = index + 1),
              );
            }),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'Tell us what you think...',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: FilledButton(
                  onPressed: _submitFeedback,
                  child: const Text('Send'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _submitFeedback() {
    final feedback = _controller.text.trim();
    if (feedback.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your feedback')),
      );
      return;
    }

    // In a real app, this would send feedback to a server
    // For now, we'll just show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Thank you for your ${_rating > 0 ? "$_rating-star " : ""}feedback!'),
        duration: const Duration(seconds: 3),
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _ReportIssueSheet extends StatefulWidget {
  @override
  State<_ReportIssueSheet> createState() => _ReportIssueSheetState();
}

class _ReportIssueSheetState extends State<_ReportIssueSheet> {
  final _controller = TextEditingController();
  String _issueType = 'Bug Report';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Report an Issue',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _issueType,
            decoration: const InputDecoration(
              labelText: 'Issue Type',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'Bug Report', child: Text('Bug Report')),
              DropdownMenuItem(value: 'Feature Request', child: Text('Feature Request')),
              DropdownMenuItem(value: 'Performance Issue', child: Text('Performance Issue')),
              DropdownMenuItem(value: 'Other', child: Text('Other')),
            ],
            onChanged: (value) => setState(() => _issueType = value!),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'Describe the issue...',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: FilledButton(
                  onPressed: _submitIssue,
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _submitIssue() {
    final issue = _controller.text.trim();
    if (issue.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please describe the issue')),
      );
      return;
    }

    // In a real app, this would send the issue report to a server
    // For now, we'll just show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$_issueType submitted successfully!'),
        duration: const Duration(seconds: 3),
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}