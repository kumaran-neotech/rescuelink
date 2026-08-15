import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class MyRequestsScreen extends StatefulWidget {
  const MyRequestsScreen({super.key});

  @override
  State<MyRequestsScreen> createState() => _MyRequestsScreenState();
}

class _MyRequestsScreenState extends State<MyRequestsScreen> {

  List<dynamic> tickets = [];

  @override
  void initState() {
    super.initState();
    loadTickets();
  }

  Future<void> loadTickets() async {
    var box = await Hive.openBox('tickets');

    setState(() {
      tickets = box.values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Requests"),
      ),

      body: tickets.isEmpty
          ? const Center(
              child: Text(
                "No Requests Found",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: tickets.length,
              itemBuilder: (context, index) {

                final ticket = tickets[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: const Icon(
                      Icons.warning,
                      color: Colors.red,
                    ),

                    title: Text(
                      ticket['location'],
                    ),

                    subtitle: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [

                        Text(
                          "Victims: ${ticket['victims']}",
                        ),

                        Text(
                          "Priority: ${ticket['priority']}",
                        ),

                        Text(
                          ticket['message'],
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