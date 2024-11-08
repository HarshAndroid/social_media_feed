import 'package:flutter/cupertino.dart';
import 'package:random_avatar/random_avatar.dart';

class ProfileAvatar extends StatelessWidget {
  final String avatar;
  final double? size;

  const ProfileAvatar(
      {super.key, required this.avatar, this.size});

  @override
  Widget build(BuildContext context) {
    return RandomAvatar(
      avatar.isEmpty ? 'test' : avatar,
      height: size ?? 42,
      width: size ?? 42,
    );
  }
}
