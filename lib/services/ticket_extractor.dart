import '../models/rescue_ticket.dart';

class TicketExtractor {
  static RescueTicket extract(String text) {
    int victims = 1;

    RegExp numberRegex = RegExp(r'\d+');
    Match? match = numberRegex.firstMatch(text);

    if (match != null) {
      victims = int.parse(match.group(0)!);
    }

    String priority = "Low";

    if (victims >= 5) {
      priority = "High";
    } else if (victims >= 2) {
      priority = "Medium";
    }

    return RescueTicket(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      victims: victims,
      location: "Unknown",
      priority: priority,
      message: text,
      timestamp: DateTime.now(),
    );
  }
}