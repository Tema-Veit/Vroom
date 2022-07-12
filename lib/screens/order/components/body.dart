import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../components/list_picker.dart';
import '../../../models/ticket_model.dart';
import '../../../util/size_config.dart';
import '../../trip/trip_screen.dart';

class Body extends StatelessWidget {
  Body({super.key, required this.ticket});

  final Ticket ticket;

  final listPickerFieldStartPoint = ListPickerField(
    label: "Точка отправления",
    items: const [
      "ТЦ Пони",
      "Вакзал",
    ],
  );

  final listPickerFieldEndPoint = ListPickerField(
    label: "Точка прибытия",
    items: const [
      "Вакзал Центральный",
      "Дружная",
      "Малиновка",
    ],
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text("$ticket"),
            SizedBox(
              height: 0.05 * SizeConfig.screenHeight,
            ),
            listPickerFieldStartPoint,
            SizedBox(
              height: 0.05 * SizeConfig.screenHeight,
            ),
            listPickerFieldEndPoint,
            SizedBox(
              height: 0.05 * SizeConfig.screenHeight,
            ),
            const TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                labelText: "Комментарий к заказу",
              ),
            ),
            SizedBox(
              height: 0.05 * SizeConfig.screenHeight,
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.phoneNumber
                        .toString())
                    .collection("active_trip")
                    .doc()
                    .set({
                  "route": ticket.route,
                  "date": ticket.date,
                  "time": ticket.time,
                  "from_point_list": ticket.fromPointList,
                  "to_point_list": ticket.toPointList,
                  "from_point": ticket.fromPoint,
                  "to_point": ticket.toPoint,
                  "cost": ticket.cost,
                  "free_places": ticket.freePlaces,
                  "car": ticket.car,
                  "car_color": ticket.carColor,
                  "car_number": ticket.carNumber,
                });
                Navigator.pushNamedAndRemoveUntil(
                    context, TripScreen.routeName, (route) => false);
              },
              child: const Text('Бронировать'),
            ),
          ],
        ),
      ),
    );
  }
}
