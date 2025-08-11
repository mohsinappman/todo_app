import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/nav_bar_cubit.dart';

class HomeNavBar extends StatefulWidget {
  const HomeNavBar({super.key});

  @override
  State<HomeNavBar> createState() => _HomeNavBarState();
}

class _HomeNavBarState extends State<HomeNavBar> {
  late NavBarCubit navBarViewModel;
  List navBarIcons = [
    Icons.home,
    Icons.calendar_month,
    Icons.lock_clock,
    Icons.person,
  ];

  @override
  void initState() {
    super.initState();
    initViewModels();
  }

  initViewModels() {
    navBarViewModel = context.read<NavBarCubit>();
  }

  void _onItemTapped(int index) {
    navBarViewModel.changeTab(tabIndex: index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarCubit, int>(
      builder: (context, activeTab) {
        return BottomNavigationBar(
          currentIndex: activeTab,
          onTap: _onItemTapped,
          items: List.generate(
            navBarViewModel.navBarItemTitles.length,
            (index) => BottomNavigationBarItem(
              icon: Icon(navBarIcons[index]),
              label: navBarViewModel.navBarItemTitles[index],
            ),
          ),
        );
      },
    );
  }
}
