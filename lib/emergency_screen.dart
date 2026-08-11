import 'package:flutter/material.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  bool sosSent = false;

  // Dummy data (replace later with speech recognition + AI)
  String recognizedText =
      "I am trapped inside the school building with five people.";

  String victims = "5";
  String location = "School Building";
  String emergency = "Building Collapse";
  String priority = "High";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        title: const Text(
          "Report Emergency",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            /// Microphone
            GestureDetector(
              onTap: () {
                // Start Voice Recognition
              },
              child: Container(
                height: 120,
                width: 120,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.mic,
                  color: Colors.white,
                  size: 60,
                ),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Tap & Speak",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            /// Recognized Text
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Recognized Text",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      recognizedText,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// AI Preview
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [

                    buildRow("Victims", victims),
                    const Divider(),

                    buildRow("Location", location),
                    const Divider(),

                    buildRow("Emergency", emergency),
                    const Divider(),

                    buildRow("Priority", priority),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            if (!sosSent)
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    setState(() {
                      sosSent = true;
                    });
                  },
                  icon: const Icon(Icons.send, color: Colors.white),
                  label: const Text(
                    "CONFIRM & SEND SOS",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

            if (sosSent) ...[
              const SizedBox(height: 25),

              Card(
                color: Colors.green.shade50,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: const [

                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 70,
                      ),

                      SizedBox(height: 15),

                      Text(
                        "SOS Sent Successfully",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),

                      SizedBox(height: 15),

                      Text(
                        "Ticket ID: RL-1024",
                        style: TextStyle(fontSize: 18),
                      ),

                      SizedBox(height: 10),

                      Text(
                        "Status: Waiting for Rescue Team",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 17),
        ),
      ],
    );
  }
}