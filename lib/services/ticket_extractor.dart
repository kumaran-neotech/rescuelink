import '../models/rescue_ticket.dart';

class TicketExtractor {
  static RescueTicket extract(String text) {
    int victims = 1;
    String priority = "Medium";

    
    final numberMatch = RegExp(r'\d+').firstMatch(text);
    if (numberMatch != null) {
      victims = int.parse(numberMatch.group(0)!);
    }

    
    if (text.toLowerCase().contains("injured") ||
        text.toLowerCase().contains("critical") ||
        victims >= 5) {
      priority = "High";
    }

    return RescueTicket(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      message: text,
      location: "Unknown",
      victims: victims,
      priority: priority,
      timestamp: DateTime.now(),
    );
  }
}