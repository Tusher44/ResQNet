import 'package:flutter/material.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  // Demo donation
  final List<Map<String, String>> donationRequests = [
    {
      "title": "Flood Relief Fund",
      "type": "Money",
      "details": "Urgent need for BDT 50,000 to buy food packs.",
    },
    {
      "title": "Medical Supplies for Cyclone Victims",
      "type": "Medicine",
      "details": "Paracetamol, antibiotics, and first-aid kits required.",
    },
    {
      "title": "Winter Supplies for Remote Villages",
      "type": "Supplies",
      "details": "Blankets, warm clothes, and dry food needed.",
    },
  ];

  void _donate(String type, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("You pledged to donate $type for '$title'")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donation Requests",
            style: TextStyle(color: Colors.white)),
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
        itemCount: donationRequests.length,
        itemBuilder: (context, index) {
          final donation = donationRequests[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    donation["title"]!,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.category, color: Colors.blue, size: 20),
                      const SizedBox(width: 6),
                      Text(
                        "Type: ${donation["type"]!}",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    donation["details"]!,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.volunteer_activism,
                          color: Colors.white),
                      label: const Text("Donate",
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () =>
                          _donate(donation["type"]!, donation["title"]!),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
