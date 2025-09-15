import 'package:flutter/material.dart';

class AchievementScreen extends StatelessWidget {
  const AchievementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example list of achievements (replace with your real data or fetch from backend)
    final achievements = [
      {"title": "Completed First Task", "date": "Jan 2023"},
      {"title": "Blood Donation Drive", "date": "Feb 2023"},
      {"title": "Disaster Relief Support", "date": "Apr 2023"},
      {"title": "Community Awareness Program", "date": "Jun 2023"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Achievements",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
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
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          final achievement = achievements[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const Icon(Icons.star, color: Color(0xFF2575FC)),
              title: Text(
                achievement["title"]!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Achieved on ${achievement["date"]}"),
            ),
          );
        },
      ),
    );
  }
}
