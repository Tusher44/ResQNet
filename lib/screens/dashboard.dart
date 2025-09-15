import 'package:flutter/material.dart';
import 'login.dart';
import 'profile.dart';
import 'achievement.dart';
import 'mytasks.dart';
import 'disaster_alart.dart';
import 'blood.dart';
import 'donation.dart';

class DashboardScreen extends StatefulWidget {
  final String role;
  const DashboardScreen({super.key, required this.role});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  String? altEmail;
  String? altPhone;

  final String volunteerName = "John Doe";
  final String volunteerPhone = "+1234567890";
  final String volunteerBloodGroup = "O+";

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      _buildDashboardBody(),
      _buildNotificationPage(),
      _buildSettingsPage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.role} Dashboard",
          style: const TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF2575FC),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notifications",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }

  // HOME TAB
  Widget _buildDashboardBody() {
    return Column(
      children: [
        _buildGradientHeader(
          "Hello ${widget.role}!",
          "Welcome to the Central Volunteering App!",
        ),
        const SizedBox(height: 20),
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            padding: const EdgeInsets.all(16),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _buildDashboardCard(Icons.task, "My Tasks", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MyTasksScreen()),
                );
              }),
              _buildDashboardCard(Icons.warning, "Disaster Alerts", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const DisasterAlertsScreen()),
                );
              }),
              _buildDashboardCard(Icons.bloodtype, "Blood Donation", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BloodDonationScreen(
                      volunteerName: volunteerName,
                      volunteerPhone: volunteerPhone,
                      volunteerBloodGroup: volunteerBloodGroup,
                    ),
                  ),
                );
              }),
              // Sponsor-only feature
              if (widget.role.toLowerCase() == "sponsor")
                _buildDashboardCard(Icons.volunteer_activism, "Donations", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DonationScreen()),
                  );
                }),
              _buildDashboardCard(Icons.map, "Map", () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("This feature is coming soon!")),
                );
              }),
              _buildDashboardCard(Icons.school, "Training", () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("This feature is coming soon!")),
                );
              }),
              _buildDashboardCard(Icons.people, "Community", () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("This feature is coming soon!")),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  //NOTIFICATIONS TAB
  Widget _buildNotificationPage() {
    return Column(
      children: [
        _buildGradientHeader("Notifications", "Stay updated with alerts!"),
        const Expanded(
          child: Center(
            child: Text(
              "No new notifications",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }

  //SETTINGS TAB
  Widget _buildSettingsPage() {
    return Column(
      children: [
        _buildGradientHeader("Settings", "Manage your preferences"),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildSettingsTile(Icons.person, "Profile", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProfileScreen(
                      altEmail: altEmail,
                      altPhone: altPhone,
                    ),
                  ),
                );
              }),
              _buildSettingsTile(Icons.lock, "Change Password", () {
                _changePassword(context);
              }),
              _buildSettingsTile(
                Icons.alternate_email,
                altEmail == null
                    ? "Add Alternative Email"
                    : "Change Alternative Email",
                () {
                  _editSingleField(
                    context,
                    "Alternative Email",
                    Icons.alternate_email,
                    (value) {
                      setState(() {
                        altEmail = value;
                      });
                    },
                    altEmail,
                  );
                },
              ),
              _buildSettingsTile(
                Icons.phone,
                altPhone == null
                    ? "Add Alternative Number"
                    : "Change Alternative Number",
                () {
                  _editSingleField(
                    context,
                    "Alternative Number",
                    Icons.phone,
                    (value) {
                      setState(() {
                        altPhone = value;
                      });
                    },
                    altPhone,
                  );
                },
              ),
              _buildSettingsTile(Icons.emoji_events, "Achievements", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AchievementScreen()),
                );
              }),
              if (widget.role.toLowerCase() == "volunteer") ...[
                const Divider(),
                _buildSettingsTile(Icons.volunteer_activism, "Become a Sponsor",
                    () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Sponsor upgrade coming soon!"),
                  ));
                }),
              ],
              const Divider(),
              _buildSettingsTile(Icons.logout, "Logout", () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                  (route) => false,
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  //Helpers
  Widget _buildGradientHeader(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(subtitle, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(IconData icon, String label, VoidCallback onTap) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: const Color(0xFF2575FC)),
              const SizedBox(height: 8),
              Text(label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsTile(IconData icon, String title, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF2575FC)),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  // Change Password
  void _changePassword(BuildContext context) {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Change Password"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: oldPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Old Password",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "New Password",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Retype New Password",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text("Save"),
              onPressed: () {
                if (newPasswordController.text ==
                    confirmPasswordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Password changed successfully!")),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("New passwords do not match")),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _editSingleField(BuildContext context, String field, IconData icon,
      Function(String) onSave, String? currentValue) {
    final controller = TextEditingController(text: currentValue ?? "");

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update $field"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: field,
              prefixIcon: Icon(icon),
              border: const OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text("Save"),
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  onSave(controller.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("$field updated")),
                  );
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
