import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:equatable/equatable.dart';

import 'package:bloc/bloc.dart';
import 'package:vroom/screens/search_ticket/search_ticket_screen.dart';

import '../../screens/login/login_screen.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late String verificationId;

  LoginBloc() : super(LoginInitial()) {
    on<InitialLogin>((event, emit) {
      emit(LoginLoading());

      User? user = FirebaseAuth.instance.currentUser;

      user == null
          ? emit(EnteringPhoneNumber())
          : Navigator.pushReplacement(
              event.context,
              MaterialPageRoute(
                  builder: (context) => const SearchTicketScreen()));
    });

    on<LoadMobileForm>((event, emit) {
      emit(EnteringPhoneNumber());
    });

    on<LoadOtpForm>((event, emit) async {
      emit(LoginLoading());

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: event.phoneNumber,
        verificationCompleted: (phoneAuthCredential) async {},
        verificationFailed: (verificationFailed) async {},
        codeSent: (verificationId, resendingToken) async {
          this.verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) async {},
      );

      emit(EnteringOtpCode());
    });

    on<VerificationAttempt>((event, emit) async {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: event.otpCode);

      signInWithPhoneAuthCredential(phoneAuthCredential, event.context);
    });

    on<LogOut>((event, emit) async {
      emit(LoginLoading());
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(event.context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
      emit(EnteringPhoneNumber());
    });
  }
}

void signInWithPhoneAuthCredential(
    PhoneAuthCredential phoneAuthCredential, BuildContext context) async {
  try {
    final authCredential =
        await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);

    if (authCredential.user != null) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(authCredential.user!.phoneNumber.toString())
          .get()
          .then(
            (doc) => {
              if (!doc.exists)
                {
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(authCredential.user!.phoneNumber.toString())
                      .set(
                    <String, dynamic>{
                      "phone": authCredential.user!.phoneNumber.toString(),
                    },
                  ),
                },
            },
          );

      Navigator.pushReplacementNamed(context, SearchTicketScreen.routeName);
    }
  } on FirebaseAuthException catch (e) {
    print("Error: $e");
  }
}
