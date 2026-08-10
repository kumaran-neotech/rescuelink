class RescueTicket {
  final String id;
  final String message;
  final String location;
  final int victims;
  final String priority;
  final DateTime timestamp;

  RescueTicket({
    required this.id,
    required this.message,
    required this.location,
    required this.victims,
    required this.priority,
    required this.timestamp,
  });
}