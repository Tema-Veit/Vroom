import 'package:equatable/equatable.dart';

class Ticket extends Equatable {
  const Ticket({
    required this.car,
    required this.carColor,
    required this.carNumber,
    required this.route,
    required this.date,
    required this.time,
    required this.cost,
    required this.freePlaces,
    required this.fromPointList,
    required this.toPointList,
    required this.fromPoint,
    required this.toPoint,
  });

  final String route;
  final String date;
  final String time;

  final String car;
  final String carColor;
  final String carNumber;

  final int cost;
  final int freePlaces;

  final List<dynamic> fromPointList;
  final List<dynamic> toPointList;

  final String fromPoint;
  final String toPoint;

  @override
  List<Object> get props => [
        route,
        date,
        time,
        car,
        carColor,
        carNumber,
        cost,
        freePlaces,
        fromPointList,
        toPointList,
        fromPoint,
        toPoint
      ];

  Ticket.fromFirebaseMap(Map<String, dynamic> data)
      : route = data['route'] as String,
        date = data['date'] as String,
        time = data['time'] as String,
        car = data['car'] as String,
        carColor = data['car_color'] as String,
        carNumber = data['car_number'] as String,
        cost = data['cost'] as int,
        freePlaces = data['free_places'] as int,
        fromPointList = data['from_point_list'] as List<dynamic>,
        toPointList = data['to_point_list'] as List<dynamic>,
        fromPoint = data['from_point'] as String,
        toPoint = data['to_point'] as String;
}
