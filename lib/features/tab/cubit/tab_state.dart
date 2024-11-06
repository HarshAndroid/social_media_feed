part of 'tab_cubit.dart';

final class TabState {
  final int bottomNavIndex;

  TabState({required this.bottomNavIndex});

  TabState copyWith({final int? bottomNavIndex}) {
    return TabState(bottomNavIndex: bottomNavIndex ?? this.bottomNavIndex);
  }
}
