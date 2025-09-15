import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final String? altEmail;
  final String? altPhone;

  const ProfileScreen({
    super.key,
    this.altEmail,
    this.altPhone,
  });

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Primary details (not editable)
  final String firstName = "John";
  final String lastName = "Doe";
  final String email = "volunteer@example.com";
  final String phone = "+1234567890";
  final String bloodGroup = "O+";

  // Editable details
  String address = "123 Volunteer St, City";

  late TextEditingController addressController =
      TextEditingController(text: address);

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  void _editField(
      BuildContext context, String title, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit $title"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
                setState(() {});
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _changeProfilePicture() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Change profile picture tapped")),
    );
  }

  Widget _buildFixedField(IconData icon, String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF2575FC)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
      ),
    );
  }

  Widget _buildEditableField(
      IconData icon, String title, TextEditingController controller) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF2575FC)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(controller.text),
        trailing: IconButton(
          icon: const Icon(Icons.edit, color: Colors.grey),
          onPressed: () => _editField(context, title, controller),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Volunteer Profile",
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile picture
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage("assets/avatar.png"),
                ),
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt,
                          color: Color(0xFF2575FC)),
                      onPressed: _changeProfilePicture,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Primary info
            _buildFixedField(Icons.person, "Name", "$firstName $lastName"),
            _buildFixedField(Icons.email, "Primary Email", email),
            _buildFixedField(Icons.phone, "Primary Contact", phone),
            _buildFixedField(Icons.bloodtype, "Blood Group", bloodGroup),

            // Address
            _buildEditableField(Icons.home, "Address", addressController),

            // Alternative fields (show only if available)
            if (widget.altEmail != null && widget.altEmail!.isNotEmpty)
              _buildFixedField(
                  Icons.alternate_email, "Alternative Email", widget.altEmail!),
            if (widget.altPhone != null && widget.altPhone!.isNotEmpty)
              _buildFixedField(
                  Icons.phone_android, "Alternative Contact", widget.altPhone!),
          ],
        ),
      ),
    );
  }
}
