import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models.dart';

final mcpClientProvider = Provider<McpMockClient>((ref) => McpMockClient());

class McpMockClient {
  // Mock Data Memory
  User? _currentUser;
  
  final List<Event> _events = [
    Event(
      id: 'e1',
      title: 'Sommet FinTech 2026',
      description: 'Conférence internationale sur la finance décentralisée et les marchés émergents.',
      date: DateTime.now().add(const Duration(days: 14)),
      price: 299.00,
      status: EventStatus.upcoming,
      imageUrl: 'https://via.placeholder.com/600x400/555f6f/FFFFFF?text=Sommet+FinTech',
    ),
    Event(
      id: 'e2',
      title: 'Design Leadership Summit',
      description: 'Rassembler les esprits créatifs de l\'industrie SaaS B2B.',
      date: DateTime.now().add(const Duration(days: 30)),
      price: 150.00,
      status: EventStatus.upcoming,
      imageUrl: 'https://via.placeholder.com/600x400/dcddfe/4f516c?text=Design+Summit',
    ),
  ];

  final List<Ticket> _tickets = [];
  
  // Auth
  Future<User> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800)); // Simulate net delay
    if (email.contains('admin')) {
      _currentUser = const User(id: 'u1', name: 'Admin Systéme', email: 'admin@tickety.com', role: Role.admin);
    } else {
      _currentUser = const User(id: 'u2', name: 'Client Pro', email: 'client@company.com', role: Role.client);
    }
    return _currentUser!;
  }
  
  User? get currentUser => _currentUser;

  // Front-Office Actions
  Future<List<Event>> getEvents() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _events;
  }

  Future<Ticket> buyTicket(String eventId) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (_currentUser == null) throw Exception("Not logged in");
    
    final newTicket = Ticket(
      id: 't_${DateTime.now().millisecondsSinceEpoch}',
      eventId: eventId,
      userId: _currentUser!.id,
      qrCodeData: 'qr_data_${eventId}_${_currentUser!.id}_${DateTime.now().millisecondsSinceEpoch}',
      purchaseDate: DateTime.now(),
      status: TicketStatus.valid,
    );
    _tickets.add(newTicket);
    return newTicket;
  }

  Future<List<Ticket>> getUserTickets() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (_currentUser == null) throw Exception("Not logged in");
    return _tickets.where((t) => t.userId == _currentUser!.id).toList();
  }

  // Back-Office Actions
  Future<List<Ticket>> getAllTickets() async {
    await Future.delayed(const Duration(milliseconds: 600));
    if (_currentUser?.role != Role.admin) throw Exception("Unauthorized");
    return _tickets;
  }

  Future<bool> validateTicketByQR(String qrData) async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (_currentUser?.role != Role.admin) throw Exception("Unauthorized");
    
    final ticketIndex = _tickets.indexWhere((t) => t.qrCodeData == qrData);
    if (ticketIndex == -1) return false; // Invalid QR

    final ticket = _tickets[ticketIndex];
    if (ticket.status == TicketStatus.valid) {
      _tickets[ticketIndex] = ticket.copyWith(status: TicketStatus.scanned);
      return true; // Scan OK
    }
    return false; // Already scanned or cancelled
  }
}
