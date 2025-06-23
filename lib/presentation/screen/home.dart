import 'package:broker/presentation/screen/holding.dart';
import 'package:flutter/material.dart';
import 'orders.dart';
import 'position.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HoldingScreen(),
    const OrdersScreen(),
    const Position(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: _screens.elementAt(_selectedIndex)),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.stacked_bar_chart),
              activeIcon: Icon(Icons.stacked_bar_chart),
              label: 'Holdings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.swap_vert),
              activeIcon: Icon(Icons.swap_vert),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.show_chart),
              activeIcon: Icon(Icons.show_chart),
              label: 'Positions',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue[600],
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
          backgroundColor: Colors.white,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}
