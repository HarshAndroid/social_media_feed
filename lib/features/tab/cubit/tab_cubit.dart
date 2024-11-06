import 'package:flutter_bloc/flutter_bloc.dart';

part 'tab_state.dart';

class TabCubit extends Cubit<TabState> {
  TabCubit() : super(TabState(bottomNavIndex: 0));

  void changeBottomNavIndex(int index) {
    //
    // if (index < 0 || index >= 4) return;

    emit(state.copyWith(bottomNavIndex: index));
  }
}
