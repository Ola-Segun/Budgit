import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Main navigation scaffold with bottom tab bar
class MainNavigationScaffold extends StatelessWidget {
  const MainNavigationScaffold({super.key, required this.child});

  final Widget child;

  static const List<String> _routes = ['/', '/transactions', '/budgets', '/goals', '/more'];

  int _getCurrentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    // Check in order from most specific to least specific
    if (location.startsWith('/more')) return 4;
    if (location.startsWith('/goals')) return 3;
    if (location.startsWith('/budgets')) return 2;
    if (location.startsWith('/transactions')) return 1;
    if (location.startsWith('/')) return 0;
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