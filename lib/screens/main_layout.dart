import 'package:flutter/material.dart';
import 'package:cnii_sentinel_flutter/screens/dashboard_screen.dart';
import 'package:cnii_sentinel_flutter/theme/app_colors.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  // Placeholder screens for the tabs until fully built out
  final List<Widget> _screens = [
    const DashboardScreen(),
    const Center(child: Text("AI Core Screen", style: TextStyle(color: Colors.white, fontFamily: 'Courier'))),
    const Center(child: Text("History Screen", style: TextStyle(color: Colors.white, fontFamily: 'Courier'))),
    const Center(child: Text("Dispatch Screen", style: TextStyle(color: Colors.white, fontFamily: 'Courier'))),
    const Center(child: Text("Settings Screen", style: TextStyle(color: Colors.white, fontFamily: 'Courier'))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        // Using a Builder provides a context scoped directly under the Scaffold
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: AppColors.textSecondary),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              "CNII Sentinel",
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: AppColors.textSecondary),
            onPressed: () {},
          )
        ],
      ),
      drawer: _buildTacticalSidebar(context),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.surface,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: _buildNavIcon(Icons.sensors, 0),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: _buildNavIcon(Icons.psychology, 1),
            label: 'AI Core',
          ),
          BottomNavigationBarItem(
            icon: _buildNavIcon(Icons.history, 2),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: _buildNavIcon(Icons.local_shipping_outlined, 3),
            label: 'Dispatch',
          ),
          BottomNavigationBarItem(
            icon: _buildNavIcon(Icons.settings_outlined, 4),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, int index) {
    bool isSelected = _currentIndex == index;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary.withOpacity(0.15) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon),
    );
  }

  // --- TACTICAL SIDEBAR DRAWER ---
  Widget _buildTacticalSidebar(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.surface,
      child: Column(
        children: [
          // Header
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.background,
              border: Border(bottom: BorderSide(color: AppColors.primary, width: 2)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Icon(Icons.shield, color: AppColors.primary, size: 36),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'CNII Sentinel',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Admin // Level 5',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 11,
                          fontFamily: 'Courier',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Navigation Links
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _drawerItem(Icons.map_outlined, 'Homepage / Live Command', 0),
                _drawerItem(Icons.psychology_outlined, 'AI Threat Hub', 1),
                _drawerItem(Icons.history, 'Incident History', 2),
                _drawerItem(Icons.local_shipping_outlined, 'Field Dispatch', 3),
                _drawerItem(Icons.settings_outlined, 'System Settings', 4),
              ],
            ),
          ),

          // Footer / Logout
          const Divider(color: Colors.white12, height: 1),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.critical.withOpacity(0.15),
                  foregroundColor: AppColors.critical,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                    side: BorderSide(color: AppColors.critical.withOpacity(0.5)),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                icon: const Icon(Icons.logout, size: 18),
                label: const Text(
                  'TERMINATE SESSION',
                  style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.0, fontSize: 12),
                ),
                onPressed: () {
                  Navigator.pop(context); // Close drawer
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, int targetIndex) {
    bool isSelected = _currentIndex == targetIndex;
    return ListTile(
      leading: Icon(
        icon, 
        color: isSelected ? AppColors.primary : AppColors.textSecondary,
      ),
      title: Text(
        title, 
        style: TextStyle(
          color: isSelected ? AppColors.primary : AppColors.textPrimary,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 14,
        ),
      ),
      tileColor: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
      onTap: () {
        setState(() => _currentIndex = targetIndex);
        Navigator.pop(context); // Close the drawer after selecting
      },
    );
  }
}