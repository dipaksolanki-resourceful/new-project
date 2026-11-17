import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/auth/auth_preferences.dart';
import 'package:new_project/auth/bloc/auth_bloc.dart';
import 'package:new_project/auth/bloc/auth_cubit.dart';
import 'package:new_project/auth/bloc/auth_service.dart';
import 'feature/home/cubit/counter_cubit.dart';
import 'feature/task/bloc/task_bloc.dart';
import 'router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CounterCubit(),
        ),
        BlocProvider(
          create: (context) => TaskBloc(),
        ),

        BlocProvider(
          create: (context) => AuthCubit(AuthService(),AuthPreferences()),
        ),
        BlocProvider(
          create: (context) => AuthBloc(AuthService()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        // home: const HomeScreen(),
        routerConfig: appRouter,
      ),
    );
  }
}

