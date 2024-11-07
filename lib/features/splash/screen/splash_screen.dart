import 'package:flutter/material.dart';

import '../../../global.dart';
import '../../auth/service/auth_service.dart';
import '../../../widget/logo.dart';
import '../../auth/screen/auth_screen.dart';
import '../../tab/screen/tab_screen.dart';

//splash screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 1000), () async {
      final autoLogin = AuthService.auth.currentUser != null;
      //
      if (mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => autoLogin ? const TabScreen() : const AuthScreen(),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.sizeOf(context);

    return Scaffold(
      //body
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: mq.height * .1),

            //app logo
            const Logo(height: 150),

            SizedBox(height: mq.height * .3),

            const CircularProgressIndicator(strokeWidth: 1),
          ],
        ),
      ),
    );
  }
}
