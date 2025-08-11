import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../router/route_names.dart';
import '../../../themes/app_colors.dart';
import '../../../widgets/custom_bottom_sheet.dart';
import '../../tasks/views/add_task_screen.dart';
import '../../tasks/views/tasks_screen.dart';
import '../cubit/nav_bar_cubit.dart';
import '../widgets/home_nav_bar.dart';

class HomeBaseScreen extends StatefulWidget {
  const HomeBaseScreen({super.key});

  @override
  State<HomeBaseScreen> createState() => _HomeBaseScreenState();
}

class _HomeBaseScreenState extends State<HomeBaseScreen> {
  late NavBarCubit navBarViewModel;
  final List<Widget> _screens = [TasksScreen()];

  @override
  void initState() {
    super.initState();
    initViewModels();
  }

  initViewModels() {
    navBarViewModel = context.read<NavBarCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: false,
              snap: false,
              leading: IconButton(
                icon: const Icon(Icons.list),
                onPressed: () {
                  context.push(RouteNames.createCategoryScreen);
                },
              ),
              centerTitle: true,
              title: BlocBuilder<NavBarCubit, int>(
                builder: (context, currentTab) {
                  return Text(
                    navBarViewModel.navBarItemTitles[currentTab],
                    style: Theme.of(context).textTheme.titleLarge,
                  );
                },
              ),
              actions: [
                ClipOval(
                  child: SizedBox(
                    height: 30.h,
                    width: 30.w,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: AppColors.lightGrey),
                      child: Icon(Icons.person),
                    ),
                  ),
                ),
              ],
            ),
          ];
        },
        body: BlocBuilder<NavBarCubit, int>(
          builder: (context, tabIndex) {
            return IndexedStack(index: tabIndex, children: _screens);
          },
        ),
      ),
      bottomNavigationBar: HomeNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAdaptiveBottomSheet(context: context, child: AddTaskView());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
