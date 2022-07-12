import 'package:flutter/material.dart';
import 'package:vroom/components/CustomBottomNavBar.dart';

import '../../util/enums.dart';
import 'components/body.dart';

class TripScreen extends StatelessWidget {
  const TripScreen({Key? key}) : super(key: key);
  static String routeName = "/trip";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text("Поездки"),
        centerTitle: true,
      ),
      body: const Body(),
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.trips),
    );
  }
}
