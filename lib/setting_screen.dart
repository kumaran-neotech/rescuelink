import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notifications = true;
  bool darkMode = false;
  bool offlineMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1565C0),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          const Text(
            "General",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Card(
            child: Column(
              children: [

                SwitchListTile(
                  secondary: const Icon(Icons.notifications),
                  title: const Text("Notifications"),
                  subtitle: const Text("Receive emergency updates"),
                  value: notifications,
                  onChanged: (value) {
                    setState(() {
                      notifications = value;
                    });
                  },
                ),

                const Divider(height: 1),

                SwitchListTile(
                  secondary: const Icon(Icons.dark_mode),
                  title: const Text("Dark Mode"),
                  subtitle: const Text("Enable dark theme"),
                  value: darkMode,
                  onChanged: (value) {
                    setState(() {
                      darkMode = value;
                    });
                  },
                ),

                const Divider(height: 1),

                SwitchListTile(
                  secondary: const Icon(Icons.wifi_off),
                  title: const Text("Offline Mode"),
                  subtitle: const Text("Keep SOS available without internet"),
                  value: offlineMode,
                  onChanged: (value) {
                    setState(() {
                      offlineMode = value;
                    });
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            "Support",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Card(
            child: Column(
              children: [

                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text("About RescueLink"),
                  subtitle: const Text("Version 1.0.0"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () {},
                ),

                const Divider(height: 1),

                ListTile(
                  leading: const Icon(Icons.help),
                  title: const Text("Help & Support"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () {},
                ),

                const Divider(height: 1),

                ListTile(
                  leading: const Icon(Icons.privacy_tip),
                  title: const Text("Privacy Policy"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () {},
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            height: 50,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                // Logout logic
              },
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text(
                "LOGOUT",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}