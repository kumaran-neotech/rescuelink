import 'package:flutter/material.dart';
import '../models/rescue_ticket.dart';
import '../storage_service.dart';
import 'current_user.dart';


class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  bool sosSent = false;

  final TextEditingController _messageController =
      TextEditingController();

  String victims = "5";
  String location = "School Building";
  String emergency = "Building Collapse";
  String priority = "High";

  String ticketId = "";

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

            /// Mic Button
            GestureDetector(
              onTap: () {
                // Voice recognition later
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

            /// User Message Input
            TextField(
              controller: _messageController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Describe your emergency...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// AI Preview Card
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
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "CONFIRM & SEND SOS",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {

                    if (_messageController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Please enter emergency details",
                          ),
                        ),
                      );
                      return;
                    }

                    ticketId =
                        DateTime.now().millisecondsSinceEpoch.toString();

                    RescueTicket ticket = RescueTicket(
                      id: ticketId,
                      userName: CurrentUser.name, // temporary value
                      userEmail: CurrentUser.email, 
                      victims: int.parse(victims),
                      location: location,
                      priority: priority,
                      status: "Pending",
                      message: _messageController.text,
                      timestamp: DateTime.now(),
                    );

                    await StorageService.saveTicket(ticket);

                    setState(() {
                      sosSent = true;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Emergency Ticket Saved",
                        ),
                      ),
                    );
                  },
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
                    children: [

                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 70,
                      ),

                      const SizedBox(height: 15),

                      const Text(
                        "SOS Sent Successfully",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        "Ticket ID: $ticketId",
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "Status: Waiting for Rescue Team",
                        style: TextStyle(
                          fontSize: 18,
                        ),
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
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
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
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
      ],
    );
  }
}