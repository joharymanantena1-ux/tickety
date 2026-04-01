// lib/core/mcp_mock/models.dart

enum Role { admin, client }
enum TicketStatus { valid, scanned, cancelled }
enum EventStatus { upcoming, ongoing, past }

class User {
  final String id;
  final String name;
  final String email;
  final Role role;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });
}

class Event {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final double price;
  final EventStatus status;
  final String imageUrl;

  const Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.price,
    required this.status,
    required this.imageUrl,
  });
}

class Ticket {
  final String id;
  final String eventId;
  final String userId;
  final String qrCodeData;
  final DateTime purchaseDate;
  final TicketStatus status;

  const Ticket({
    required this.id,
    required this.eventId,
    required this.userId,
    required this.qrCodeData,
    required this.purchaseDate,
    required this.status,
  });

  Ticket copyWith({
    String? id,
    String? eventId,
    String? userId,
    String? qrCodeData,
    DateTime? purchaseDate,
    TicketStatus? status,
  }) {
    return Ticket(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      userId: userId ?? this.userId,
      qrCodeData: qrCodeData ?? this.qrCodeData,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      status: status ?? this.status,
    );
  }
}
