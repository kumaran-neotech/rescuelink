import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'login_signup_screen.dart';
import 'current_user.dart';

class VolunteerScreen extends StatelessWidget {
  const VolunteerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('tickets');

   return Scaffold(
  appBar: AppBar(
    backgroundColor: Colors.blue,
    title: const Text(
      "Volunteer Dashboard",
      style: TextStyle(color: Colors.white),
    ),
    actions: [
      IconButton(
        icon: const Icon(
  Icons.logout,
  color: Colors.white,
),
        onPressed: () {
          CurrentUser.name = "";
          CurrentUser.email = "";
          CurrentUser.role = "";

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false,
          );
        },
      ),
    ],
  ),

  body: Column(
    children: [

      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          "Logged in as: ${CurrentUser.name}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),

      Expanded(
        child: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, Box box, _) {

            if (box.isEmpty) {
              return const Center(
                child: Text(
                  "No Emergency Tickets",
                  style: TextStyle(fontSize: 18),
                ),
              );
            }


          return ListView.builder(
            itemCount: box.length,

            itemBuilder: (context, index) {

              final ticket = box.getAt(index);

              return Card(
                margin: const EdgeInsets.all(10),
                elevation: 4,

                child: Padding(
                  padding: const EdgeInsets.all(15),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Text(
                        "Ticket ID: ${ticket['id']}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),
                      Text("User: ${ticket['userName']}"),
                      Text("Email: ${ticket['userEmail']}"),

                      Text(
                        "Location: ${ticket['location']}",
                      ),

                      Text(
                        "Victims: ${ticket['victims']}",
                      ),

                      Text(
  " 🚨${ticket['priority']}",
  style: TextStyle(
    color: ticket['priority'] == "High"
        ? Colors.red
        : Colors.orange,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  ),
),

                      Text(
                        "Status: ${ticket['status']}",
                      ),
                      

                      const SizedBox(height: 10),

                      Text(
                        ticket['message'],
                      ),

                      const SizedBox(height: 15),

                      if (ticket['status'] == "Pending")

                        ElevatedButton(
                          onPressed: () {

                            ticket['status'] =
                                "Assigned";

                            box.putAt(index, ticket);

                          },

                          child: const Text(
                            "Accept Mission",
                          ),
                        ),

                                           if (ticket['status'] == "Assigned")
                        const Chip(
                          label: Text(
                            "Assigned",
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    ),
  ],
),
);
  }
}