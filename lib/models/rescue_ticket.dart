class RescueTicket {
  final String id;
  final String userName;
  final String userEmail;
  final String message;
  final String location;
  final int victims;
  final String priority;
  final String status;
  final DateTime timestamp;

  RescueTicket({
    required this.id,
    required this.userName,
    required this.userEmail,
    required this.message,
    required this.location,
    required this.victims,
    required this.priority,
    required this.status,
    required this.timestamp,
  });
}