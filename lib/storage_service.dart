import 'package:hive/hive.dart';
import 'models/rescue_ticket.dart';

class StorageService {
  static Future<void> saveTicket(
      RescueTicket ticket) async {

    final box = await Hive.openBox('tickets');

    await box.add({
      'id': ticket.id,
      'userName': ticket.userName,
      'userEmail': ticket.userEmail,
      'victims': ticket.victims,
      'priority': ticket.priority,
      'location': ticket.location,
      'message': ticket.message,
      'status': ticket.status,
      'time': ticket.timestamp.toString(),
    });
  }

  static Future<Box> getTicketsBox() async {
    return await Hive.openBox('tickets');
  }

  static Future<void> deleteTicket(
      int index) async {

    final box = await Hive.openBox('tickets');

    await box.deleteAt(index);
  }
}