import 'package:flutter/cupertino.dart';
import 'package:random_avatar/random_avatar.dart';

class ProfileAvatar extends StatelessWidget {
  final String avatar;
  final double? width, height;

  const ProfileAvatar(
      {super.key, required this.avatar, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return RandomAvatar(
      avatar.isEmpty ? 'test' : avatar,
      height: height ?? 42,
      width: width ?? 42,
    );
  }
}
