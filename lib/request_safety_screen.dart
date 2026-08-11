import 'package:flutter/material.dart';

class RequestsSafetyScreen extends StatefulWidget {
  const RequestsSafetyScreen({super.key});

  @override
  State<RequestsSafetyScreen> createState() => _RequestsSafetyScreenState();
}

class _RequestsSafetyScreenState extends State<RequestsSafetyScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget requestCard(
      String ticketId,
      String priority,
      String status,
      Color color,
      ) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: const Icon(
            Icons.warning,
            color: Colors.white,
          ),
        ),
        title: Text(
          ticketId,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Priority: $priority\nStatus: $status"),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  Widget safetyTip(IconData icon, String title, String subtitle) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.green,
          size: 32,
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        title: const Text(
          "RescueLink",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(
              icon: Icon(Icons.assignment),
              text: "My Requests",
            ),
            Tab(
              icon: Icon(Icons.health_and_safety),
              text: "Safety Tips",
            ),
          ],
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: [

          /// MY REQUESTS
          Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                requestCard(
                    "RL-1024", "High", "Waiting", Colors.red),
                requestCard(
                    "RL-1025", "Medium", "Team Assigned", Colors.orange),
                requestCard(
                    "RL-1026", "Low", "Completed", Colors.green),
              ],
            ),
          ),

          /// SAFETY TIPS
          Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                safetyTip(
                  Icons.water_drop,
                  "During Flood",
                  "Move to higher ground and avoid walking through flood water.",
                ),
                safetyTip(
                  Icons.local_fire_department,
                  "During Fire",
                  "Use stairs instead of elevators and stay close to the ground.",
                ),
                safetyTip(
                  Icons.landscape,
                  "During Earthquake",
                  "Drop, Cover and Hold until the shaking stops.",
                ),
                safetyTip(
                  Icons.medical_services,
                  "First Aid",
                  "Keep a first-aid kit and emergency medicines ready.",
                ),
                safetyTip(
                  Icons.phone,
                  "Emergency Contacts",
                  "Keep important emergency numbers saved offline.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}