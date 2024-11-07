import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/tab_cubit.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      //curve shape for fab
      shape: const CircularNotchedRectangle(),

      //navigation bar
      child: BlocSelector<TabCubit, TabState, int>(
        selector: (state) => state.bottomNavIndex,
        builder: (context, state) {
          return NavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedIndex: state,
              animationDuration: const Duration(seconds: 1),
              onDestinationSelected:
                  context.read<TabCubit>().changeBottomNavIndex,
              destinations: const [
                //feed
                NavigationDestination(
                  icon: Icon(CupertinoIcons.bubble_left),
                  label: 'Feed',
                ),

                //profile
                NavigationDestination(
                  icon: Icon(CupertinoIcons.person),
                  label: 'Profile',
                )
              ]);
        },
      ),
    );
  }
}
