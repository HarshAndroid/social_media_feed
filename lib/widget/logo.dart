import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double? height;
  const Logo({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: const AssetImage('assets/logo.png'),
      height: height ?? 100,
    );
  }
}
