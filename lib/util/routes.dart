import 'package:flutter/widgets.dart';

import '../screens/login/login_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/search_ticket/search_ticket_screen.dart';
import '../screens/trip/trip_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => const LoginScreen(),
  SearchTicketScreen.routeName: (context) => const SearchTicketScreen(),
  TripScreen.routeName: (context) => const TripScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
};
