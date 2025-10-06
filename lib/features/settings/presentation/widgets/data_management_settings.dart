import 'package:flutter/material.dart';

/// Widget for data management settings
class DataManagementSettings extends StatelessWidget {
  const DataManagementSettings({
    super.key,
    required this.onExportData,
    required this.onImportData,
    required this.onClearData,
  });

  final VoidCallback onExportData;
  final VoidCallback onImportData;
  final VoidCallback onClearData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Export Data'),
          subtitle: const Text('Export all your data to a file'),
          leading: const Icon(Icons.download),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: onExportData,
        ),
        const Divider(),
        ListTile(
          title: const Text('Import Data'),
          subtitle: const Text('Import data from a backup file'),
          leading: const Icon(Icons.upload),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: onImportData,
        ),
        const Divider(),
        ListTile(
          title: const Text('Clear All Data'),
          subtitle: const Text('Permanently delete all app data'),
          leading: Icon(Icons.delete_forever, color: Theme.of(context).colorScheme.error),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: onClearData,
        ),
      ],
    );
  }
}