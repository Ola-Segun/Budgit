import 'package:flutter/material.dart';


/// Settings tile for theme mode selection
class ThemeSettingsTile extends StatelessWidget {
  const ThemeSettingsTile({
    super.key,
    required this.currentThemeMode,
    required this.onThemeModeChanged,
  });

  final ThemeMode currentThemeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.palette),
      title: const Text('Theme'),
      subtitle: Text(_getThemeModeText(currentThemeMode)),
      trailing: DropdownButton<ThemeMode>(
        value: currentThemeMode,
        onChanged: (value) {
          if (value != null) {
            onThemeModeChanged(value);
          }
        },
        items: ThemeMode.values.map((mode) {
          return DropdownMenuItem(
            value: mode,
            child: Text(_getThemeModeText(mode)),
          );
        }).toList(),
      ),
    );
  }

  String _getThemeModeText(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'System';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }
}