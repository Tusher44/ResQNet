import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final String role; // "Volunteer" or "Sponsor"

  const DashboardScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("$role Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Top banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello $role!",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "Welcome to the Central Volunteering App!",
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Grid Menu
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(16),
              crossAxisCount: 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children: _buildMenuItems(role),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMenuItems(String role) {
    if (role == "Volunteer") {
      return [
        _menuItem(Icons.assignment, "My Tasks"),
        _menuItem(Icons.warning, "Disaster Alerts"),
        _menuItem(Icons.map, "Task Map"),
        _menuItem(Icons.school, "Training"),
        _menuItem(Icons.chat, "Community"),
        _menuItem(Icons.person, "Profile"),
      ];
    } else if (role == "Sponsor") {
      return [
        _menuItem(Icons.volunteer_activism, "Donate"),
        _menuItem(Icons.campaign, "Campaigns"),
        _menuItem(Icons.bar_chart, "Impact Reports"),
        _menuItem(Icons.history, "My Contributions"),
        _menuItem(Icons.message, "Updates"),
        _menuItem(Icons.person, "Profile"),
      ];
    }
    return [];
  }

  Widget _menuItem(IconData icon, String label) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to feature screen
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: Colors.red),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
