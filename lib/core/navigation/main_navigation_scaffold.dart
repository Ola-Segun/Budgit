import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Main navigation scaffold with bottom tab bar
class MainNavigationScaffold extends StatelessWidget {
  const MainNavigationScaffold({super.key, required this.child});

  final Widget child;

  static const List<String> _routes = ['/', '/transactions', '/budgets', '/goals', '/more'];

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    for (int i = 0; i < _routes.length; i++) {
      if (location.startsWith(_routes[i])) {
        return i;
      }
    }
    return 0; // Default to home
  }

  void _onTabTapped(BuildContext context, int index) {
    context.go(_routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _getCurrentIndex(context),
        onTap: (index) => _onTabTapped(context, index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Text('🏠', style: TextStyle(fontSize: 20)),
            activeIcon: Text('🏠', style: TextStyle(fontSize: 20)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Text('💳', style: TextStyle(fontSize: 20)),
            activeIcon: Text('💳', style: TextStyle(fontSize: 20)),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Text('📊', style: TextStyle(fontSize: 20)),
            activeIcon: Text('📊', style: TextStyle(fontSize: 20)),
            label: 'Budgets',
          ),
          BottomNavigationBarItem(
            icon: Text('🎯', style: TextStyle(fontSize: 20)),
            activeIcon: Text('🎯', style: TextStyle(fontSize: 20)),
            label: 'Goals',
          ),
          BottomNavigationBarItem(
            icon: Text('⋯', style: TextStyle(fontSize: 20)),
            activeIcon: Text('⋯', style: TextStyle(fontSize: 20)),
            label: 'More',
          ),
        ],
      ),
    );
  }
}