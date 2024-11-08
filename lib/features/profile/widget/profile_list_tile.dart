import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/model/profile_option.dart';

class ProfileListTile extends StatelessWidget {
  final ProfileOption option;

  const ProfileListTile({super.key, required this.option});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      minLeadingWidth: 0,
      //icon
      leading: Icon(
        option.icon,
        color: Theme.of(context).primaryColorLight,
      ),

      //title
      title: Text(
        option.title,
        style: const TextStyle(fontSize: 15),
      ),

      //forward arrow
      trailing: Icon(
        CupertinoIcons.right_chevron,
        size: 22,
        color: Theme.of(context).primaryColorLight,
      ),

      //
      onTap: () => option.onTap(context),
    );
  }
}
