import 'package:flutter/material.dart';
import 'models/rescue_ticket.dart';
import 'services/ticket_extractor.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final TextEditingController _controller = TextEditingController();

  RescueTicket? ticket;

  void generateTicket() {
    setState(() {
      ticket = TicketExtractor.extract(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Ticket Test"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter Emergency Message",
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: generateTicket,
              child: const Text("Generate Ticket"),
            ),

            const SizedBox(height: 20),

            if (ticket != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text("Victims: ${ticket!.victims}"),
                      Text("Priority: ${ticket!.priority}"),
                      Text("Location: ${ticket!.location}"),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}