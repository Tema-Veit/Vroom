import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vroom/models/ticket_model.dart';
import 'package:vroom/screens/order/order_screen.dart';

part 'search_ticket_event.dart.dart';
part 'search_ticket_state.dart.dart';

class SearchTicketBloc extends Bloc<SearchTicketEvent, SearchTicketState> {
  SearchTicketBloc() : super(TicketInitial()) {
    on<InitialTicket>((event, emit) {});

    on<UpdateTicket>((event, emit) {
      emit(TicketInitial());
    });

    on<LoadTicket>((event, emit) async {
      emit(TicketLoading());

      final tickets =
          await fetchAllTickets(event.route, event.passengers, event.date);

      emit(TicketLoaded(tickets: tickets));
    });

    on<PickTicket>(((event, emit) {
      Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) => OrderScreen(
            ticket: event.ticket,
          ),
        ),
      );
    }));
  }
}

Future<List<Ticket>> fetchAllTickets(
    String route, String passengers, String date) async {
  List<Ticket> tickets = [];

  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection("routes")
      .doc(route)
      .collection(date)
      .where(
        "free_places",
        isGreaterThanOrEqualTo: int.parse(
          passengers.split(' ')[0],
        ),
      )
      .get();
  for (var i = 0; i < querySnapshot.docs.length; i++) {
    //  postList.add(Post.fromSnapshot(querySnapshot.docs[i].data() as Map<String, dynamic>));
    tickets.add(Ticket.fromFirebaseMap(
        querySnapshot.docs[i].data() as Map<String, dynamic>));
  }
  return tickets;
}
