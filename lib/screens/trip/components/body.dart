import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vroom/bloc/trip_bloc/trip_bloc.dart';

import '../../../bloc/search_ticket_bloc/search_ticket_bloc.dart';
import '../../../util/size_config.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<TripBloc>().add(InitialActiveTrip());
    return BlocBuilder<TripBloc, TripState>(
      builder: (context, state) {
        if (state is TripLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ActiveTrip) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: state.tickets.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        color: Colors.lightBlueAccent, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    splashColor: Colors.lightBlueAccent.withAlpha(30),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: SizeConfig.screenHeight * 0.20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(state.tickets[index].route),
                              ],
                            ),
                            Text("Дата: ${state.tickets[index].date}"),
                            Text("Время: ${state.tickets[index].time}"),
                            Text(
                                "Свободно мест: ${state.tickets[index].freePlaces}"),
                            Text(
                                "Стоимость:  ${state.tickets[index].cost} руб"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(state.tickets[index].car),
                                Text(state.tickets[index].carColor),
                                Text(state.tickets[index].carNumber),
                              ],
                            ),
                            TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.lightBlueAccent),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                              ),
                              onPressed: () {
                                context.read<SearchTicketBloc>().add(PickTicket(
                                      ticket: state.tickets[index],
                                      context: context,
                                    ));
                              },
                              child: const Text('Бронировать'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        } else {
          return const Text("something went wrong");
        }
      },
    );
  }
}
