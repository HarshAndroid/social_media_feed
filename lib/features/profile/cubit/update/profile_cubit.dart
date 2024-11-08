import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../service/dialog_x.dart';
import '../../../auth/service/auth_service.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  //
  ProfileCubit()
      : super(
          ProfileState(photo: _photo),
        );

  static String get _photo => AuthService.auth.currentUser?.photoURL ?? '';
  static String get _displayName =>
      AuthService.auth.currentUser?.displayName ?? '';

  final nameC = TextEditingController()..text = _displayName;

  Future<void> updateProfilePhoto() async {
    final photo = DateTime.now().toIso8601String();

    emit(ProfileState(photo: photo));
  }

  Future<void> updateProfile(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());

    nameC.text = nameC.text.trim();
    if (nameC.text.isEmpty) {
      DialogX.info(msg: 'Please fill the Username');
      return;
    }

    DialogX.showProgressBar(context);
    final user = AuthService.auth.currentUser;

    try {
      if (_displayName != nameC.text) await user?.updateDisplayName(nameC.text);
      if (_photo != state.photo) await user?.updatePhotoURL(state.photo);

      if (context.mounted) {
        Navigator.pop(context);
        DialogX.success(msg: 'Profile Updated Successfully!');
      }
    } catch (_) {
      if (context.mounted) {
        Navigator.pop(context);
        DialogX.error();
      }
    }
  }

  void handleOnDispose() {
    if (_photo != state.photo) {
      emit(ProfileState(photo: _photo));
    }
  }

  @override
  Future<void> close() async {
    super.close();
    nameC.dispose();
  }
}
