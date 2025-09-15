import 'package:flutter/material.dart';

class BloodDonationScreen extends StatefulWidget {
  final String volunteerName;
  final String volunteerPhone;
  final String volunteerBloodGroup;

  const BloodDonationScreen({
    super.key,
    required this.volunteerName,
    required this.volunteerPhone,
    required this.volunteerBloodGroup,
  });

  @override
  State<BloodDonationScreen> createState() => _BloodDonationScreenState();
}

class _BloodDonationScreenState extends State<BloodDonationScreen> {
  bool showEligibleOnly = false;

  // Demo blood requests with patient contact info
  List<Map<String, dynamic>> requests = [
    {
      "patient": "Rahim Uddin",
      "patientPhone": "+8801712345678",
      "hospital": "Dhaka Medical College",
      "bloodGroup": "O+",
      "urgency": "High",
      "volunteer": null,
    },
    {
      "patient": "Shila Akter",
      "patientPhone": "+8801812345678",
      "hospital": "Chittagong General Hospital",
      "bloodGroup": "A+",
      "urgency": "Medium",
      "volunteer": null,
    },
    {
      "patient": "Tanvir Hasan",
      "patientPhone": "+8801912345678",
      "hospital": "Rajshahi Medical College",
      "bloodGroup": "B+",
      "urgency": "Low",
      "volunteer": null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredRequests = showEligibleOnly
        ? requests
            .where((r) => r["bloodGroup"] == widget.volunteerBloodGroup)
            .toList()
        : requests;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Blood Donation Requests",
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Row(
            children: [
              const Text("Eligible Only",
                  style: TextStyle(color: Colors.white, fontSize: 14)),
              Switch(
                value: showEligibleOnly,
                activeColor: Colors.white,
                onChanged: (val) {
                  setState(() => showEligibleOnly = val);
                },
              ),
            ],
          ),
        ],
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
        itemCount: filteredRequests.length,
        itemBuilder: (context, index) {
          var req = filteredRequests[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.bloodtype, color: Colors.red, size: 32),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "${req['patient']} (${req['bloodGroup']})",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text("Hospital: ${req['hospital']}"),
                  Text("Urgency: ${req['urgency']}"),
                  const SizedBox(height: 6),

                  // Patient Contact
                  Text("Patient Contact: ${req['patientPhone']}",
                      style: const TextStyle(fontWeight: FontWeight.w500)),

                  const SizedBox(height: 6),

                  // Volunteer Contact (if assigned)
                  if (req['volunteer'] != null)
                    Text(
                        "Volunteer: ${req['volunteer']['name']} - ${req['volunteer']['phone']}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.green)),

                  const SizedBox(height: 8),

                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: req['volunteer'] == null
                          ? () {
                              setState(() {
                                req['volunteer'] = {
                                  "name": widget.volunteerName,
                                  "phone": widget.volunteerPhone,
                                };
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    "You volunteered to help ${req['patient']}! Contact shared."),
                              ));
                            }
                          : null,
                      child: const Text("Help / Donate"),
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
