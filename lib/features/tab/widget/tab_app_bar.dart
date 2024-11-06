import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/cubit/theme_cubit.dart';
import '../../../widget/logo.dart';
import '../cubit/tab_cubit.dart';

class TabAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TabAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    //list of tab titles
    final tabsTitle = [
      InkWell(
          onTap: () {
            context.read<ThemeCubit>().changeTheme();
          },
          child: const Logo(height: 35)),

      //
      const Text('Profile'),
    ];

    return BlocSelector<TabCubit, TabState, int>(
      selector: (state) => state.bottomNavIndex,
      builder: (context, state) {
        return AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: tabsTitle[state],

          //actions
          actions: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (state == 0)
                  IconButton(
                    splashRadius: 25,
                    tooltip: 'App Theme',
                    visualDensity: const VisualDensity(horizontal: -4),
                    onPressed: () => context.read<ThemeCubit>().changeTheme(),
                    icon: BlocSelector<ThemeCubit, ThemeState, bool>(
                      selector: (state) => state.isDarkMode,
                      builder: (context, state) {
                        return Padding(
                          padding: state
                              ? const EdgeInsets.only(bottom: 2)
                              : EdgeInsets.zero,
                          child: Icon(
                            state
                                ? CupertinoIcons.moon_stars
                                : CupertinoIcons.sun_max,
                            color: state
                                ? const Color(0xCCFFFFFF)
                                : const Color(0xCC000000),
                          ),
                        );
                      },
                    ),
                  ),
                const SizedBox(width: 8)
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 60);
}
