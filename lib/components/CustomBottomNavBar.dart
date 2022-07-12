import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vroom/screens/search_ticket/search_ticket_screen.dart';

import '../bloc/search_ticket_bloc/search_ticket_bloc.dart';

import '../screens/profile/profile_screen.dart';
import '../screens/trip/trip_screen.dart';

import '../util/constants.dart';
import '../util/enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    const Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Search Icon.svg",
                  color: MenuState.search == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () async {
                  BlocProvider.of<SearchTicketBloc>(context)
                      .add(InitialTicket());
                  Navigator.pushReplacementNamed(
                      context, SearchTicketScreen.routeName);
                }),
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/Bill Icon.svg",
                color: MenuState.trips == selectedMenu
                    ? kPrimaryColor
                    : inActiveIconColor,
              ),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, TripScreen.routeName),
            ),
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/User Icon.svg",
                color: MenuState.profile == selectedMenu
                    ? kPrimaryColor
                    : inActiveIconColor,
              ),
              onPressed: () => Navigator.pushReplacementNamed(
                  context, ProfileScreen.routeName),
            ),
          ],
        ),
      ),
    );
  }
}
