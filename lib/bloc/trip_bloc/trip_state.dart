part of 'trip_bloc.dart';

abstract class TripState extends Equatable {
  const TripState();

  @override
  List<Object> get props => [];
}

class TripInitial extends TripState {}

class TripLoading extends TripState {}

class ActiveTrip extends TripState {
  final List<Ticket> tickets;

  const ActiveTrip({this.tickets = const <Ticket>[]});

  @override
  List<Object> get props => [tickets];
}

class HistoryTrip extends TripState {}
