import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global.dart';
import '../../feed/data/feed_repository.dart';
import '../../feed/data/model/feed.dart';
import '../../feed/screen/feed.dart';
import '../../profile/screen/profile.dart';
import '../cubit/tab_cubit.dart';
import '../widget/bottom_nav.dart';
import '../widget/lazy_loading_indexed_stack.dart';
import '../widget/tab_app_bar.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.sizeOf(context);
    //list of tabs
    const tabsList = [FeedScreen(), ProfileScreen()];

    final tabCubit = context.read<TabCubit>();

    return PopScope(
      canPop: false,
      // canPop: tabCubit.state.bottomNavIndex != 0,
      onPopInvokedWithResult: (didPop, _) {
        log('onPopInvoked: ${tabCubit.state.bottomNavIndex}');

        tabCubit.state.bottomNavIndex != 0
            ? tabCubit.changeBottomNavIndex(0)
            : {
                Future.delayed(
                    const Duration(milliseconds: 1000), SystemNavigator.pop)
              };
      },

      //
      child: Scaffold(
        //app bar
        appBar: const TabAppBar(),

        //fab
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final feed = FeedModel(
                postId: DateTime.now().millisecondsSinceEpoch.toString(),
                content:
                    'Go as far as you can see and once you reach their, you will be able to see further',
                userId: 'random-user',
                username: 'random',
                likesCount: 1,
                commentsCount: 0,
                likedByUsers: ['random-user']);
            FeedRepository.addPost(feed);
          },
          child: const Icon(CupertinoIcons.plus, size: 28),
        ),

        //body
        body: BlocSelector<TabCubit, TabState, int>(
            bloc: tabCubit,
            selector: (state) => state.bottomNavIndex,
            builder: (context, state) {
              return LazyLoadIndexedStack(
                index: state,
                children: tabsList,
              );
            }),

        //bottom nav
        bottomNavigationBar: const BottomNav(),
      ),
    );
  }
}
