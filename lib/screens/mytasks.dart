import 'package:flutter/material.dart';

class MyTasksScreen extends StatefulWidget {
  const MyTasksScreen({super.key});

  @override
  State<MyTasksScreen> createState() => _MyTasksScreenState();
}

class _MyTasksScreenState extends State<MyTasksScreen> {
  // Sample tasks with date & status
  final List<Map<String, dynamic>> tasks = [
    {
      "title": "Distribute Relief Kits",
      "done": false,
      "date": "12 Sept 2025",
    },
    {
      "title": "Blood Donation Camp",
      "done": true,
      "date": "8 Sept 2025",
    },
    {
      "title": "Rescue Drill Training",
      "done": false,
      "date": "20 Sept 2025",
    },
    {
      "title": "Community Awareness Program",
      "done": true,
      "date": "5 Sept 2025",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Tasks",
          style: TextStyle(color: Colors.white),
        ),
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
      body: Column(
        children: [
          // Gradient header
          Container(
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
              children: const [
                Text(
                  "My Tasks",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Mark tasks as completed when done",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          // Task list with switch
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Icon(
                      task["done"] ? Icons.check_circle : Icons.pending,
                      color: task["done"] ? Colors.green : Colors.orange,
                    ),
                    title: Text(task["title"]),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task["done"]
                              ? "Status: Completed"
                              : "Status: Pending",
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Date: ${task["date"]}",
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                    trailing: Switch(
                      value: task["done"],
                      activeColor: Colors.green,
                      onChanged: (value) {
                        setState(() {
                          task["done"] = value;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "${task["title"]} marked as ${value ? "Completed" : "Pending"}",
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),

          // Footer note
          Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            color: Colors.grey.shade200,
            child: const Center(
              child: Text(
                "Future tasks will be notified soon!",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
