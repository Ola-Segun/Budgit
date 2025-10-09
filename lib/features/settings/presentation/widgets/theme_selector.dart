import 'package:flutter/material.dart';


/// Widget for selecting theme mode
class ThemeSelector extends StatelessWidget {
  const ThemeSelector({
    super.key,
    required this.currentTheme,
    required this.onThemeChanged,
  });

  final ThemeMode currentTheme;
  final ValueChanged<ThemeMode> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Theme'),
          subtitle: Text(_getThemeModeText(currentTheme)),
          leading: Icon(_getThemeModeIcon(currentTheme)),
          trailing: const Icon(Icons.arrow_drop_down),
          onTap: () => _showThemeSelectionDialog(context),
        ),
      ],
    );
  }

  String _getThemeModeText(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.system:
        return 'System default';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }

  IconData _getThemeModeIcon(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.system:
        return Icons.brightness_auto;
      case ThemeMode.light:
        return Icons.brightness_high;
      case ThemeMode.dark:
        return Icons.brightness_low;
    }
  }

  void _showThemeSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildThemeOption(context, ThemeMode.system, 'System default', Icons.brightness_auto),
            _buildThemeOption(context, ThemeMode.light, 'Light', Icons.brightness_high),
            _buildThemeOption(context, ThemeMode.dark, 'Dark', Icons.brightness_low),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption(BuildContext context, ThemeMode themeMode, String title, IconData icon) {
    final isSelected = currentTheme == themeMode;

    return ListTile(
      leading: Icon(icon, color: isSelected ? Theme.of(context).colorScheme.primary : null),
      title: Text(title),
      trailing: isSelected ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) : null,
      onTap: () {
        onThemeChanged(themeMode);
        Navigator.pop(context);
      },
    );
  }
}