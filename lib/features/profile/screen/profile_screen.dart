import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global.dart';
import '../../../widget/profile_avatar.dart';
import '../../auth/service/auth_service.dart';
import '../cubit/update/profile_cubit.dart';
import '../data/model/profile_option.dart';
import '../widget/profile_list_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = AuthService.auth.currentUser;

    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: mq.height * .04),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            //profile avatar
            BlocSelector<ProfileCubit, ProfileState, String>(
              selector: (state) => state.photo,
              builder: (context, state) {
                return ProfileAvatar(
                  avatar: state ,
                  size: mq.height * .15,
                );
              },
            ),

            const SizedBox(height: 10),

            Text(
              user?.email ?? '',
              style: TextStyle(color: Theme.of(context).primaryColorLight),
            ),

            //divider
            Padding(
              padding: EdgeInsets.only(top: mq.height * .03),
              child: const Divider(color: Colors.grey),
            ),
            //
            ...ProfileOption.values.map((e) => ProfileListTile(option: e))
          ],
        ));
  }
}
