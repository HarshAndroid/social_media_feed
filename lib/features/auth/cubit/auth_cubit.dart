import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../service/dialog_x.dart';
import '../../../../service/pref.dart';
import '../service/auth_service.dart';
import '../../tab/screen/tab_screen.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit()
      : super(AuthState(
          hidePass: true,
          isNewUser: false,
          keepSignedIn: Pref.keepSignedIn,
        ));

  void updateHidePass() => emit(state.copyWith(hidePass: !state.hidePass));

  void updateIsNewUser() => emit(state.copyWith(isNewUser: !state.isNewUser));

  void updateKeepSignedIn(bool? keepSignedIn) {
    if (keepSignedIn == null || keepSignedIn == state.keepSignedIn) return;

    emit(state.copyWith(keepSignedIn: keepSignedIn));
    Pref.keepSignedIn = keepSignedIn;
  }

  String? _validate(final String email, final String password) {
    final isEmailValid =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
            .hasMatch(email);

    if (isEmailValid == false) return 'Invalid Email address';

    if (password.length < 8) return 'Password is too short';

    return null;
  }

  Future<void> handleButtonClick(
    final BuildContext context,
    final TextEditingController emailC,
    final TextEditingController passwordC,
  ) async {
    final email = emailC.text.trim();
    final password = passwordC.text.trim();

    final isValid = _validate(email, password);
    if (isValid != null) {
      DialogX.info(msg: isValid);
      return;
    }

    DialogX.showProgressBar(context);

    final success = await (state.isNewUser
        ? AuthService.register(email, password)
        : AuthService.login(email, password));

    if (context.mounted) Navigator.pop(context);

    if (success) {
      Pref.email = state.keepSignedIn ? email : '';
      Pref.password = state.keepSignedIn ? password : '';
      Pref.keepSignedIn = state.keepSignedIn;

      if (state.isNewUser) {
        passwordC.clear();
        emit(state.copyWith(isNewUser: false));

        DialogX.success(
            msg:
                'Congratulations! You\'ve successfully registered. Please log in to continue.');

        return;
      }

      if (context.mounted) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const TabScreen()));
      }
      DialogX.success(
          msg: 'You\'ve successfully logged in! Enjoy your experience.');

      try {
        await AuthService.auth.currentUser?.updatePhotoURL(email);
      } catch (_) {}
    }
  }
}
