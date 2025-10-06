import 'package:flutter/material.dart';

/// Settings tile for data management operations
class DataManagementTile extends StatelessWidget {
  const DataManagementTile({
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
          leading: const Icon(Icons.download),
          title: const Text('Export Data'),
          subtitle: const Text('Download your data as JSON or CSV'),
          trailing: const Icon(Icons.chevron_right),
          onTap: onExportData,
        ),
        const Divider(height: 1),
        ListTile(
          leading: const Icon(Icons.upload),
          title: const Text('Import Data'),
          subtitle: const Text('Import data from a backup file'),
          trailing: const Icon(Icons.chevron_right),
          onTap: onImportData,
        ),
        const Divider(height: 1),
        ListTile(
          leading: Icon(Icons.delete_forever, color: Theme.of(context).colorScheme.error),
          title: Text('Clear All Data', style: TextStyle(color: Theme.of(context).colorScheme.error)),
          subtitle: const Text('Permanently delete all data'),
          trailing: Icon(Icons.chevron_right, color: Theme.of(context).colorScheme.error),
          onTap: onClearData,
        ),
      ],
    );
  }
}