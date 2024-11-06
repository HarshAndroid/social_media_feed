import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/tab_cubit.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const AutomaticNotchedShape(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      child: BlocSelector<TabCubit, TabState, int>(
        selector: (state) => state.bottomNavIndex,
        builder: (context, state) {
          return NavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedIndex: state,
              onDestinationSelected: (i) {
                context.read<TabCubit>().changeBottomNavIndex(i);
              },
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
