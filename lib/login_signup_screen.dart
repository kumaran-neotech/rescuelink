import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'home_screen.dart';
import 'volunteer_screen.dart';
import 'current_user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final loginEmailController = TextEditingController();
final loginPasswordController = TextEditingController();

final signupNameController = TextEditingController();
final signupEmailController = TextEditingController();
final signupPhoneController = TextEditingController();
final signupPasswordController = TextEditingController();

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

void signup() async {

  final usersBox = Hive.box('users');

  String email =
      signupEmailController.text.trim();

  if (!email.endsWith("@gmail.com")) {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Only Gmail accounts allowed",
        ),
      ),
    );

    return;
  }

  await usersBox.put(
    email,
    {
      "name": signupNameController.text,
      "email": email,
      "phone": signupPhoneController.text,
      "password": signupPasswordController.text,
      "role": "user",
    },
  );

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Signup Successful"),
    ),
  );
}
void login() {

  final usersBox = Hive.box('users');

  String email =
      loginEmailController.text.trim();

  String password =
      loginPasswordController.text.trim();

  if (!usersBox.containsKey(email)) {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("User Not Found"),
      ),
    );

    return;
  }

  Map user =
      Map.from(usersBox.get(email));

  if (user["password"] != password) {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Wrong Password"),
      ),
    );

    return;
  }

  CurrentUser.name = user["name"];
  CurrentUser.email = user["email"];
  CurrentUser.role = user["role"];

  if (CurrentUser.role == "volunteer") {

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const VolunteerScreen(),
      ),
    );

  } else {

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const HomeScreen(),
      ),
    );
  }
}
  void goToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
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
                    // LOGIN TAB
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          TextField(
  controller: loginEmailController,
  decoration: inputDecoration(
    "Email",
    Icons.person,
  ),
),

                          const SizedBox(height: 15),

                          TextField(
                            controller: loginPasswordController,
                            obscureText: true,
                            decoration: inputDecoration(
                              "Password",
                              Icons.lock,
                            ),
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
                              onPressed: login,
                              child: const Text(
                                "LOGIN",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          OutlinedButton(
                            onPressed: goToHome,
                            child: const Text("Continue as Guest"),
                          ),
                        ],
                      ),
                    ),

                    // SIGNUP TAB
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          TextField(
                           controller: signupNameController,
                           decoration: inputDecoration(
                           "Full Name",
                              Icons.person,
                            ),
                          ),

                          const SizedBox(height: 15),

                          TextField(
  controller: signupPhoneController,
  decoration: inputDecoration(
    "Phone Number",
                              Icons.phone,
                            ),
                          ),

                          const SizedBox(height: 15),

TextField(
  controller: signupEmailController,
  decoration: inputDecoration(
    "Gmail",
    Icons.email,
  ),
),

                          const SizedBox(height: 15),

                          TextField(
  controller: signupPasswordController,
  obscureText: true,
                            decoration: inputDecoration(
                              "Password",
                              Icons.lock,
                            ),
                          ),

                          const SizedBox(height: 25),

                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: signup,
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