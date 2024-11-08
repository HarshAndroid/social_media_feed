import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global.dart';
import '../../../helper/extension.dart';
import '../../auth/service/auth_service.dart';
import '../cubit/update/profile_cubit.dart';
import 'edit_profile_avatar.dart';

class EditProfileDialog extends StatefulWidget {
  const EditProfileDialog({super.key});

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  late final _c = context.read<ProfileCubit>();

  @override
  void initState() {
    super.initState();
    _c.nameC.text = ProfileCubit.displayName;
  }

  @override
  void deactivate() {
    _c.handleOnDispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final height = mq.height * .03;

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        //app bar
        appBar: AppBar(title: const Text('Edit Profile')),

        //body
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: mq.width * .04,
            vertical: mq.height * .02,
          ),
          child: Column(
            children: [
              // Avatar
              EditProfileAvatar(c: _c),

              //
              const SizedBox(height: 6),

              //email
              Text(
                AuthService.auth.currentUser?.email ?? '',
                style: TextStyle(color: Theme.of(context).primaryColorLight),
              ),

              //for adding some space
              SizedBox(height: mq.height * .04),

              //first name
              TextField(
                controller: _c.nameC,
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration(
                    hintText: 'User Name',
                    prefixIcon: Icon(CupertinoIcons.person, size: 24)),
              ),

              //for adding some space
              SizedBox(height: height),

              //
              Align(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(mq.width * .45, 46),
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () => _c.updateProfile(context),
                  child: const Text('Save Changes'),
                ),
              ),
            ].animateList,
          ),
        ),
      ),
    );
  }
}
