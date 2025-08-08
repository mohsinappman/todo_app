import 'package:bloc/bloc.dart';

class NavBarCubit extends Cubit<int> {
  NavBarCubit() : super(0);
  List navBarItemTitles = ['Index', 'Calendar', 'Focus', 'Profile'];

  changeTab({required int tabIndex}) async {
    emit(tabIndex);
  }
}
