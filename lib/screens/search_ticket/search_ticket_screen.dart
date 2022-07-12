import 'package:flutter/material.dart';

import 'package:vroom/components/CustomBottomNavBar.dart';

import '../../util/enums.dart';
import 'components/body.dart';

class SearchTicketScreen extends StatelessWidget {
  const SearchTicketScreen({Key? key}) : super(key: key);
  static String routeName = "/search";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text("Vroom"),
        centerTitle: true,
      ),
      body: const Body(),
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.search),
    );
  }
}
