import 'dart:developer';

import 'package:flutter/material.dart';

import '../global.dart';

class DialogX {
  static final snackbarKey = GlobalKey<ScaffoldMessengerState>();

  //error
  static void error({String? msg}) {
    final snackBar = SnackBar(
      content: Text(
        msg ?? 'Something went wrong. Check your internet connection.',
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.redAccent.withOpacity(.8),
    );

    showSnackbar(snackBar);
  }

  //success
  static void success({required String msg}) {
    final snackBar = SnackBar(
      content: Text(
        msg,
        style: const TextStyle(color: Colors.white),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green.withOpacity(.8),
    );

    showSnackbar(snackBar);
  }

  //info
  static void info({required String msg}) {
    final snackBar = SnackBar(
      content: Text(
        msg,
        style: const TextStyle(color: Colors.white),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: pColor,
    );

    showSnackbar(snackBar);
  }

  //show common progress
  static void showProgressBar(final BuildContext context) => dialog(
      context, const Center(child: CircularProgressIndicator(strokeWidth: 1)));

  //show snackbar
  static void showSnackbar(final SnackBar snackBar) {
    try {
      snackbarKey.currentState?.showSnackBar(snackBar);
    } catch (e) {
      log('_showSnackbar: $e');
    }
  }

  // // show dialog
  static void dialog(final BuildContext context, final Widget widget,
      {final bool barrierDismissible = true}) {
    try {
      //
      showDialog(
        context: context,
        builder: (_) => Center(child: widget),
        barrierDismissible: barrierDismissible,
      );
    } catch (e) {
      log('_showDialog: $e');
    }
  }
}
