import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'emergency_screen.dart';
import 'request_safety_screen.dart';
import 'setting_screen.dart';
import 'my_requests_screen.dart';
import 'volunteer_screen.dart';
import 'current_user.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 65, 65),
        elevation: 0,
        title: const Text(
          "RescueLink",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
           onPressed: () {
  Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) =>
        const MyRequestsScreen(),
  ),
);
},
          ),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              // Welcome Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1565C0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  children: [
                    const Icon(
                      Icons.health_and_safety,
                      color: Colors.white,
                      size: 70,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Welcome to RescueLink",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Offline Disaster Communication",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Emergency Button
              SizedBox(
                width: double.infinity,
                height: 70,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                 icon: const Icon(
                Icons.emergency,
                color: Colors.white,
                size: 30,
                  ),
                  label: const Text(
                    "REPORT EMERGENCY",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EmergencyScreen(),
                        ),
                      );
                    },
                ),
              ),

              const SizedBox(height: 25),

              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  children: [

                  _menuCard(
  Icons.assignment,
  "My Requests",
  Colors.orange,
  () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MyRequestsScreen(),
      ),
    );
  },
),

                    _menuCard(
                      Icons.shield,
                      "Safety Tips",
                      Colors.green,
                      () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RequestsSafetyScreen(),
                            ),
                          );
                        },
                    ),

                    _menuCard(
                      Icons.account_circle,
                      "Profile",
                      Colors.indigo,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileScreen(),
                          ),
                        );
                      },
                    ),

  if (CurrentUser.role == "volunteer")
  _menuCard(
    Icons.volunteer_activism,
    "Volunteer",
    Colors.blue,
    () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const VolunteerScreen(),
        ),
      );
    },
  ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
   
  }

  Widget _menuCard(
      IconData icon,
      String title,
      Color color,
      VoidCallback onTap,
      ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: color.withOpacity(0.15),
                child: Icon(
                  icon,
                  color: color,
                  size: 30,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}