import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/features/auth/views/sign_in_screen.dart';
import '../core/features/auth/views/sign_up_screen.dart';
import '../core/features/base/views/home_base_screen.dart';
import '../core/features/category/views/create_category_screen.dart';
import '../core/features/tasks/views/update_task_screen.dart';
import 'route_names.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final session = Supabase.instance.client.auth.currentSession;
      final isLoggedIn = session != null;

      final isGoingToSignIn = state.fullPath == RouteNames.signInScreen;
      final isGoingToSignUp = state.fullPath == '/';

      if (!isLoggedIn && !isGoingToSignIn && !isGoingToSignUp) {
        return RouteNames.signInScreen;
      }

      if (isLoggedIn && (isGoingToSignUp || isGoingToSignIn)) {
        return RouteNames.homeBaseScreen;
      }

      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SignUpScreen()),
      GoRoute(
        path: RouteNames.signInScreen,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: RouteNames.homeBaseScreen,
        builder: (context, state) => const HomeBaseScreen(),
      ),
      GoRoute(
        path: RouteNames.createCategoryScreen,
        builder: (context, state) => const CreateCategoryScreen(),
      ),
      GoRoute(
        path: RouteNames.updateTaskScreen,
        builder: (context, state) => const UpdateTaskScreen(),
      ),
    ],
  );
}
