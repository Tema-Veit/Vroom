part of 'search_ticket_bloc.dart';

abstract class SearchTicketEvent extends Equatable {
  const SearchTicketEvent();

  @override
  List<Object> get props => [];
}

class InitialTicket extends SearchTicketEvent {}

class UpdateTicket extends SearchTicketEvent {}

class LoadTicket extends SearchTicketEvent {
  final String route;
  final String passengers;
  final String date;

  const LoadTicket(
      {required this.route, required this.passengers, required this.date});

  @override
  List<Object> get props => [route, passengers, date];
}

class PickTicket extends SearchTicketEvent {
  final BuildContext context;
  final Ticket ticket;
  const PickTicket({required this.ticket, required this.context});
}

// class ReservationsTicket extends SearchTicketEvent {
//   final BuildContext context;
//   final Ticket ticket;
//   const ReservationsTicket({required this.ticket, required this.context});
// }
