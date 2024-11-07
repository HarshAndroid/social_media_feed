import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/add_feed/cubit/add_feed_cubit.dart';
import 'features/auth/cubit/auth_cubit.dart';
import 'features/tab/cubit/tab_cubit.dart';
import 'firebase_options.dart';

import 'features/splash/screen/splash_screen.dart';
import 'global.dart';
import 'service/dialog_x.dart';
import 'service/pref.dart';
import 'theme/cubit/theme_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Pref.initializeDB();

  await _initializeFirebase();

  //enter full-screen
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  //for setting orientation to portrait only
  await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _themeCubit = ThemeCubit();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _themeCubit),
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => TabCubit()),
        BlocProvider(create: (_) => AddFeedCubit()),
      ],
      child: BlocSelector<ThemeCubit, ThemeState, bool>(
        selector: (state) => state.isDarkMode,
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            scaffoldMessengerKey: DialogX.snackbarKey,
            title: appName,

            themeMode: state ? ThemeMode.dark : ThemeMode.light,

            darkTheme: _themeCubit.darkTheme,

            //theme
            theme: _themeCubit.lightTheme,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}

Future<void> _initializeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}
