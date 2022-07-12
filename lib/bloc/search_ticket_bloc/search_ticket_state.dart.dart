part of 'search_ticket_bloc.dart';

abstract class SearchTicketState extends Equatable {
  const SearchTicketState();

  @override
  List<Object> get props => [];
}

class TicketInitial extends SearchTicketState {}

class TicketUpdate extends SearchTicketState {}

class TicketLoading extends SearchTicketState {}

class TicketLoaded extends SearchTicketState {
  final List<Ticket> tickets;

  const TicketLoaded({this.tickets = const <Ticket>[]});

  @override
  List<Object> get props => [tickets];
}
