import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
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

  InputDecoration inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              const Icon(
                Icons.health_and_safety,
                size: 90,
                color: Colors.red,
              ),

              const SizedBox(height: 15),

              const Text(
                "RescueLink",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                "Offline Disaster Communication",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.red,
                  labelColor: Colors.red,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(text: "Login"),
                    Tab(text: "Sign Up"),
                  ],
                ),
              ),

              SizedBox(
                height: 500,
                child: TabBarView(
                  controller: _tabController,
                  children: [

                    /// LOGIN
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          TextField(
                            decoration: inputDecoration(
                                "Phone / Email", Icons.person),
                          ),
                          const SizedBox(height: 15),
                          TextField(
                            obscureText: true,
                            decoration: inputDecoration(
                                "Password", Icons.lock),
                          ),
                          const SizedBox(height: 10),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text("Forgot Password?"),
                            ),
                          ),

                          const SizedBox(height: 15),

                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () {
                                // Navigate to Home Screen
                              },
                              child: const Text(
                                "LOGIN",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          OutlinedButton(
                            onPressed: () {
                              // Guest Mode
                            },
                            child: const Text("Continue as Guest"),
                          ),
                        ],
                      ),
                    ),

                    /// SIGN UP
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          TextField(
                            decoration: inputDecoration(
                                "Full Name", Icons.person),
                          ),
                          const SizedBox(height: 15),

                          TextField(
                            decoration: inputDecoration(
                                "Phone Number", Icons.phone),
                          ),
                          const SizedBox(height: 15),

                          TextField(
                            decoration: inputDecoration(
                                "Emergency Contact", Icons.contact_phone),
                          ),
                          const SizedBox(height: 15),

                          TextField(
                            obscureText: true,
                            decoration: inputDecoration(
                                "Password", Icons.lock),
                          ),
                          const SizedBox(height: 25),

                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () {
                                // Register User
                              },
                              child: const Text(
                                "SIGN UP",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
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
}