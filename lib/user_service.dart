import 'package:hive/hive.dart';

class UserService {

  static Future<void> registerUser(
      String name,
      String email,
      String password,
      String role,
      ) async {

    final box = await Hive.openBox('users');

    await box.put(email, {
      "name": name,
      "email": email,
      "password": password,
      "role": role,
    });
  }

  static Future<dynamic> login(
      String email,
      String password,
      ) async {

    final box = await Hive.openBox('users');

    var user = box.get(email);

    if (user == null) {
      return null;
    }

    if (user["password"] == password) {
      return user;
    }

    return null;
  }
}