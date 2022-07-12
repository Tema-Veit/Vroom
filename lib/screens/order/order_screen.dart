import 'package:flutter/material.dart';
import 'package:vroom/models/ticket_model.dart';

import 'components/body.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key, required this.ticket}) : super(key: key);

  static String routeName = "/order";

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: const Text("Order Screen"),
        centerTitle: true,
      ),
      body: Body(ticket: ticket),
    );
  }
}
