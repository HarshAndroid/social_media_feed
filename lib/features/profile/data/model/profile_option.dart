import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../auth/screen/auth_screen.dart';
import '../../../auth/service/auth_service.dart';
import '../../widget/edit_profile_dialog.dart';

enum ProfileOption {
  editProfile,
  helpCenter,
  developedBy,
  logout,
}

extension MyOptions on ProfileOption {
  //title
  String get title => switch (this) {
        ProfileOption.editProfile => 'Edit Profile',
        ProfileOption.helpCenter => 'Help Center',
        ProfileOption.developedBy => 'Developed by Harsh Rajpurohit',
        ProfileOption.logout => 'Logout',
      };

  //icon
  IconData get icon => switch (this) {
        ProfileOption.editProfile => CupertinoIcons.person,
        ProfileOption.helpCenter => Icons.support_agent_rounded,
        ProfileOption.developedBy => CupertinoIcons.device_laptop,
        ProfileOption.logout => Icons.logout_rounded,
      };

  //on tap
  Function get onTap => switch (this) {
        //edit profile
        ProfileOption.editProfile => (BuildContext context) {
            showDialog(
                context: context,
                useSafeArea: false,
                barrierDismissible: false,
                builder: (_) => const EditProfileDialog());
          },

        //helpCenter
        ProfileOption.helpCenter => (BuildContext context) {
            launchUrlString(
              'mailto:rajpurohitharsh2020@gmail.com',
              mode: LaunchMode.externalApplication,
            );
          },

        //share
        ProfileOption.developedBy => (BuildContext context) {
            launchUrlString(
              'https://github.com/HarshAndroid',
              mode: LaunchMode.externalApplication,
            );
          },

        //logout
        ProfileOption.logout => (BuildContext context) async {
            final success = await AuthService.logout();
            if (success && context.mounted) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const AuthScreen()));
            }
          },
      };
}
