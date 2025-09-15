import 'package:flutter/material.dart';

class DisasterAlertsScreen extends StatelessWidget {
  const DisasterAlertsScreen({super.key});

  // Demo data
  final List<Map<String, dynamic>> alerts = const [
    {
      "title": "Cyclone Warning",
      "location": "Chittagong & Cox’s Bazar Coast",
      "date": "15 Sept 2025, 10:00 AM",
      "severity": "High"
    },
    {
      "title": "Flood Alert",
      "location": "Sylhet Division",
      "date": "14 Sept 2025, 6:00 PM",
      "severity": "High"
    },
    {
      "title": "Heatwave Warning",
      "location": "Dhaka & Rajshahi",
      "date": "13 Sept 2025, 2:00 PM",
      "severity": "Medium"
    },
    {
      "title": "Riverbank Erosion Risk",
      "location": "Kurigram, Gaibandha",
      "date": "12 Sept 2025, 11:30 AM",
      "severity": "Medium"
    },
    {
      "title": "Tornado Alert",
      "location": "Khulna Division",
      "date": "11 Sept 2025, 4:45 PM",
      "severity": "Low"
    },
  ];

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case "High":
        return Colors.red;
      case "Medium":
        return Colors.orange;
      case "Low":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Disaster Alerts",
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
        itemCount: alerts.length,
        itemBuilder: (context, index) {
          final alert = alerts[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(
                Icons.warning,
                color: _getSeverityColor(alert["severity"]),
                size: 32,
              ),
              title: Text(
                alert["title"],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Location: ${alert["location"]}"),
                  Text("Date: ${alert["date"]}"),
                ],
              ),
              trailing: Text(
                alert["severity"],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _getSeverityColor(alert["severity"]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
