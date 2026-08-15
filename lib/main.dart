import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'login_signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox('users');
  await Hive.openBox('tickets');

  final usersBox = Hive.box('users');

  // Volunteer Accounts
  await usersBox.put(
    "admin001@rescuelink.com",
    {
      "name": "Volunteer 1",
      "email": "admin001@rescuelink.com",
      "password": "rescue001",
      "role": "volunteer",
    },
  );

  await usersBox.put(
    "admin002@rescuelink.com",
    {
      "name": "Volunteer 2",
      "email": "admin002@rescuelink.com",
      "password": "rescue002",
      "role": "volunteer",
    },
  );

  await usersBox.put(
    "admin003@rescuelink.com",
    {
      "name": "Volunteer 3",
      "email": "admin003@rescuelink.com",
      "password": "rescue003",
      "role": "volunteer",
    },
  );

  runApp(const RescueLinkApp());
}

class RescueLinkApp extends StatelessWidget {
  const RescueLinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RescueLink',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const LoginScreen(),
    );
  }
}