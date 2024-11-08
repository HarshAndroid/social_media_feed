import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widget/profile_avatar.dart';
import '../cubit/update/profile_cubit.dart';

class EditProfileAvatar extends StatelessWidget {
  final ProfileCubit c;

  const EditProfileAvatar({super.key, required this.c});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          BlocSelector<ProfileCubit, ProfileState, String>(
            bloc: c,
            selector: (state) => state.photo,
            builder: (context, state) =>
                ProfileAvatar(avatar: state, size: 130),
          ),

          //
          Positioned(
            bottom: 10,
            right: 0,
            child: InkWell(
              onTap: c.updateProfilePhoto,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(2),
                  ),
                ),
                child: Icon(
                  CupertinoIcons.shuffle,
                  size: 18,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
