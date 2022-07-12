import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/login_bloc/login_bloc.dart';

import 'miles_card.dart';
import 'phome_card.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const PhoneCard(),
              const MilesCard(),
              const SizedBox(
                height: 50,
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () async {
                  // SetTrips();
                  context.read<LoginBloc>().add(LogOut(context: context));
                },
                child: const Text('Выйти'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


  // Future SetTrips() async {
  //   final routes = FirebaseFirestore.instance.collection("routes");
  //   final data1 = <String, dynamic>{
  //     "route": "Новогрудок - Барановичи",
  //     "date": "11.7.2022",
  //     "time": "8:00",
  //     "from_point_list": ["Завод", "Баня", "ТЦ Корона", "Автовакзал"],
  //     "to_point_list": ["ТЭЦ", "ТЦ Корона", "Рынок", "Автовокзал"],
  //     "from_point": "Автовакзал",
  //     "to_point": "Автовакзал",
  //     "cost": 15,
  //     "free_places": 18,
  //     "car": "Mercedes-Benz, Sprinter",
  //     "car_color": "Белый",
  //     "car_number": "AM 7644-8",
  //   };

  //   await routes
  //       .doc(data1["route"])
  //       .collection(data1["date"])
  //       .doc(data1["time"])
  //       .set(data1);

  //   final data2 = <String, dynamic>{
  //     "route": "Новогрудок - Барановичи",
  //     "date": "11.7.2022",
  //     "time": "14:00",
  //     "from_point_list": ["Завод", "Баня", "ТЦ Корона", "Автовакзал"],
  //     "to_point_list": ["ТЭЦ", "ТЦ Корона", "Рынок", "Автовокзал"],
  //     "from_point": "Автовакзал",
  //     "to_point": "Автовакзал",
  //     "cost": 12,
  //     "free_places": 5,
  //     "car": "Mercedes-Benz, Sprinter",
  //     "car_color": "Синий",
  //     "car_number": "IG 7634-2",
  //   };
  //   await routes
  //       .doc(data2["route"])
  //       .collection(data2["date"])
  //       .doc(data2["time"])
  //       .set(data2);

  //   final data3 = <String, dynamic>{
  //     "route": "Новогрудок - Барановичи",
  //     "date": "12.7.2022",
  //     "time": "14:00",
  //     "from_point_list": ["Завод", "Баня", "ТЦ Корона", "Автовакзал"],
  //     "to_point_list": ["ТЭЦ", "ТЦ Корона", "Рынок", "Автовокзал"],
  //     "from_point": "Автовакзал",
  //     "to_point": "Автовакзал",
  //     "cost": 12,
  //     "free_places": 5,
  //     "car": "Mercedes-Benz, Sprinter",
  //     "car_color": "Синий",
  //     "car_number": "IG 7634-2",
  //   };
  //   await routes
  //       .doc(data3["route"])
  //       .collection(data3["date"])
  //       .doc(data3["time"])
  //       .set(data3);

  //   final data4 = <String, dynamic>{
  //     "route": "Барановичи - Новогрудок",
  //     "date": "12.7.2022",
  //     "time": "16:00",
  //     "from_point_list": ["Завод", "Баня", "ТЦ Корона", "Автовакзал"],
  //     "to_point_list": ["ТЭЦ", "ТЦ Корона", "Рынок", "Автовокзал"],
  //     "from_point": "Автовакзал",
  //     "to_point": "Автовакзал",
  //     "cost": 10,
  //     "free_places": 2,
  //     "car": "Mercedes-Benz, Sprinter",
  //     "car_color": "Чёрный",
  //     "car_number": "IG 7224-5",
  //   };
  //   await routes
  //       .doc(data4["route"])
  //       .collection(data4["date"])
  //       .doc(data4["time"])
  //       .set(data4);

  //   final data5 = <String, dynamic>{
  //     "route": "Новогрудок - Барановичи",
  //     "date": "11.7.2022",
  //     "time": "16:00",
  //     "from_point_list": ["Завод", "Баня", "ТЦ Корона", "Автовакзал"],
  //     "to_point_list": ["ТЭЦ", "ТЦ Корона", "Рынок", "Автовокзал"],
  //     "from_point": "Автовакзал",
  //     "to_point": "Автовакзал",
  //     "cost": 11,
  //     "free_places": 2,
  //     "car": "Mercedes-Benz, Sprinter",
  //     "car_color": "Белый",
  //     "car_number": "РТ 4144-5",
  //   };

  //   await routes
  //       .doc(data5["route"])
  //       .collection(data5["date"])
  //       .doc(data5["time"])
  //       .set(data5);

  //   final data6 = <String, dynamic>{
  //     "route": "Новогрудок - Барановичи",
  //     "date": "11.7.2022",
  //     "time": "18:00",
  //     "from_point_list": ["Завод", "Баня", "ТЦ Корона", "Автовакзал"],
  //     "to_point_list": ["ТЭЦ", "ТЦ Корона", "Рынок", "Автовокзал"],
  //     "from_point": "Автовакзал",
  //     "to_point": "Автовакзал",
  //     "cost": 15,
  //     "free_places": 4,
  //     "car": "Mercedes-Benz, Sprinter",
  //     "car_color": "Белый",
  //     "car_number": "КП 4156-6",
  //   };

  //   await routes
  //       .doc(data6["route"])
  //       .collection(data6["date"])
  //       .doc(data6["time"])
  //       .set(data6);
  // }