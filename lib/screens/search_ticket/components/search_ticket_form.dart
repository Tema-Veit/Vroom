import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vroom/models/ticket_model.dart';
import 'package:vroom/util/constants.dart';

import '../../../bloc/search_ticket_bloc/search_ticket_bloc.dart';

import '../../../components/DatePickerButtun.dart';
import '../../../components/list_picker.dart';

import '../../../util/size_config.dart';

class SearchTicketForm extends StatelessWidget {
  SearchTicketForm({Key? key}) : super(key: key);

  final listPickerFieldRoute = ListPickerField(
    label: "Маршрут",
    items: const [
      "Новогрудок - Барановичи",
      "Барановичи - Новогрудок",
      "Молодечно - Минск",
      "Минск - Молодечно",
      "Сморгонь - Мосты",
      "Мосты - Сморгонь",
      "Витебск - Могилёв",
      "Брест - Гродно",
      "Могилёв - Витебск",
      "Гомель - Браслав",
      "Гродно - Брест",
      "Слоним - Ошмяны",
      "Ошмяны - Слоним",
      "Браслав - Гомель"
    ],
  );

  final listPickerFieldPassengers = ListPickerField(
    label: "Пассажиры",
    items: const [
      "1 пассажир",
      "2 пассажира",
      "3 пассажира",
      "4 пассажира",
      "5 пассажира",
    ],
  );

  final datePickerField = DatePickerField(
    label: "Дата",
  );

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Column(
      children: [
        SizedBox(
          height: 0.2 * SizeConfig.screenHeight,
        ),
        listPickerFieldRoute,
        const SizedBox(
          height: 20,
        ),
        listPickerFieldPassengers,
        const SizedBox(
          height: 20,
        ),
        datePickerField,
        const SizedBox(
          height: 20,
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: () {
            if (listPickerFieldRoute.value.isNotEmpty &&
                listPickerFieldPassengers.value.isNotEmpty &&
                datePickerField.value.isNotEmpty) {
              context.read<SearchTicketBloc>().add(LoadTicket(
                  route: listPickerFieldRoute.value.toString(),
                  passengers: listPickerFieldPassengers.value.toString(),
                  date: datePickerField.value.toString()));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: Duration(seconds: 2),
                  backgroundColor: kPrimaryColor,
                  content: Text(
                      "Выберите маршрут, количество пассажиров и дату поездки"),
                ),
              );
            }
          },
          child: const Text('Найти'),
        ),
        SizedBox(
          height: 0.05 * SizeConfig.screenHeight,
        ),

        BlocBuilder<SearchTicketBloc, SearchTicketState>(
          builder: (context, state) {
            if (state is TicketInitial) {
              return const SizedBox();
            }
            if (state is TicketLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is TicketLoaded) {
              if (state.tickets.isEmpty) {
                return const Text("no tickets");
              }
              return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                    context
                                        .read<SearchTicketBloc>()
                                        .add(PickTicket(
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
        ),
        // .orderBy('time')
      ],
    );
  }
}
