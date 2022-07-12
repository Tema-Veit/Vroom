import 'package:flutter/material.dart';
import 'package:vroom/util/size_config.dart';

class MilesCard extends StatelessWidget {
  const MilesCard({Key? key}) : super(key: key);

  final String miles = "4550";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.lightBlueAccent, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.grey[40],
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
            width: double.infinity, child: Text("Баланс миль\n$miles")),
      ),
    );
  }
}
