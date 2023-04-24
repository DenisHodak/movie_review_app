import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationHomepage());

  void changeView(int index) {
    switch (index) {
      case 0:
        emit(NavigationHomepage());
        break;
      case 1:
        emit(NavigationFavorites());
        break;
      default:
    }
  }
}
