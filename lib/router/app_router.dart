import 'package:go_router/go_router.dart';
import 'package:new_project/auth/screens/login_screen.dart';
import 'package:new_project/auth/screens/signup_screen.dart';
import 'package:new_project/splash_screen.dart';
import '../feature/task/screen/task_detail_screen.dart';
import '../feature/home/screen/home_screen.dart';
import '../feature/profile/profile_screen.dart';
import '../widgets/app_shell.dart';

import '../feature/task/screen/tasks_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/tasks',
              builder: (context, state) => const TasksScreen(),routes: [
                GoRoute(path: ':taskId',builder:(context, state) {
                  final taskId =  state.pathParameters['taskId']!;
                  return TaskDetailsScreen(taskId: taskId);
                }, )
            ]
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/signup', builder: (context, state) => const SignupScreen()),
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
  ],
);
