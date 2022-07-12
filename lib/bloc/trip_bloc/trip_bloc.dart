import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vroom/models/ticket_model.dart';

part 'trip_event.dart';
part 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  TripBloc() : super(TripInitial()) {
    on<InitialActiveTrip>((event, emit) async {
      emit(TripLoading());

      final tickets = await fetchAllActiveTripTickets();

      emit(ActiveTrip(tickets: tickets));
    });
  }
}

Future<List<Ticket>> fetchAllActiveTripTickets() async {
  List<Ticket> tickets = [];

  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.phoneNumber.toString())
      .collection("active_trip")
      .get();
  for (var i = 0; i < querySnapshot.docs.length; i++) {
    //  postList.add(Post.fromSnapshot(querySnapshot.docs[i].data() as Map<String, dynamic>));
    tickets.add(Ticket.fromFirebaseMap(
        querySnapshot.docs[i].data() as Map<String, dynamic>));
  }
  return tickets;
}
