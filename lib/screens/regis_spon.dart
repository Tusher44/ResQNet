import 'package:flutter/material.dart';

class SponsorDashboard extends StatelessWidget {
  const SponsorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Sponsor Dashboard"),
        backgroundColor: const Color(0xFF2575FC),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              "Welcome, Sponsor!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Grid of colorful cards
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildCard("Donate", Icons.volunteer_activism, Colors.green,
                    Colors.lightGreenAccent),
                _buildCard("Campaigns", Icons.campaign, Colors.blue,
                    Colors.lightBlueAccent),
                _buildCard("Impact Reports", Icons.bar_chart, Colors.orange,
                    Colors.deepOrangeAccent),
                _buildCard("My Contributions", Icons.history, Colors.purple,
                    Colors.deepPurpleAccent),
                _buildCard(
                    "Updates", Icons.message, Colors.teal, Colors.tealAccent),
                _buildCard("Profile", Icons.person, Colors.indigo,
                    Colors.indigoAccent),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
      String title, IconData icon, Color startColor, Color endColor) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [startColor, endColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: startColor.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
