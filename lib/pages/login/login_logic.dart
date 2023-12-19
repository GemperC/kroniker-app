import 'package:koala/pages/home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:koala/pages/login/login_page.dart';

import '../../backend/auth/google_auth.dart';
import '../../utils/utils.dart';
import '../../widgets/route/route_widget.dart';
import 'login_model.dart';

void navigateToHomeWidget(context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => HomeWidget(),
    ),
    (r) => false,
  );
}

Future<void> signIn(context, LoginModel _model) async {
  try {
    final user = await signInWithGoogle(context);
    if (user == null) {
      return;
    }
  } on FirebaseAuthException catch (e) {
    print(e.code);
    switch (e.code) {
      case 'network-request-failed':
        Utils.showSnackBar('Error: No internet connection');

        return null;

      case 'user-not-found':
        Utils.showSnackBar('Invalid credentials');

        return null;

      case 'unknown':
        Utils.showSnackBar('Please enter your email and password');

        Navigator.pop(context);
        return null;

      case 'invalid-email':
        Utils.showSnackBar('Please enter a valid email address');

        Navigator.pop(context);
        return null;

      case 'wrong-password':
        Utils.showSnackBar('Incorrect password');

        Navigator.pop(context);
        return null;

      default:
        Utils.showSnackBar(e.message);
    }
  }
}
