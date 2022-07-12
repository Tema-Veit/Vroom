import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vroom/screens/search_ticket/search_ticket_screen.dart';

import '../../../bloc/login_bloc/login_bloc.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  getMobileFormWidget() {
    final phoneController = TextEditingController();
    return Column(
      children: [
        const Spacer(),
        TextField(
          keyboardType: TextInputType.phone,
          controller: phoneController,
          decoration: const InputDecoration(
            hintText: "Phone Number",
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: () async {
            context
                .read<LoginBloc>()
                .add(LoadOtpForm(phoneNumber: phoneController.text));
          },
          child: const Text("SEND"),
        ),
        const Spacer(),
      ],
    );
  }

  getOtpFormWidget() {
    final otpController = TextEditingController();
    return Column(
      children: [
        const Spacer(),
        TextField(
          keyboardType: TextInputType.number,
          controller: otpController,
          decoration: const InputDecoration(
            hintText: "Enter OTP",
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: () async {
            context.read<LoginBloc>().add(VerificationAttempt(
                otpCode: otpController.text, context: context));
          },
          child: const Text("VERIFY"),
        ),
        const Spacer(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<LoginBloc>().add(InitialLogin(context: context));
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginLoading) {
              return const CircularProgressIndicator();
            }
            if (state is EnteringPhoneNumber) {
              return getMobileFormWidget();
            }
            if (state is EnteringOtpCode) {
              return getOtpFormWidget();
            }
            if (state is SuccessfulLogin) {
              return const SearchTicketScreen();
            } else {
              return const Text("something went wrong");
            }
          },
        ),
      ),
    );
  }
}
