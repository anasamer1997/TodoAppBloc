import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tasks_app/bloc/bloc_export.dart';
import 'package:flutter_tasks_app/service/app_router.dart';
import 'package:flutter_tasks_app/service/app_theme.dart';
import 'screens/tasks_screen.dart';

void main() {
  // ignore: deprecated_member_use
  BlocOverrides.runZoned(() => runApp(MyApp(
        appRouter: AppRouter(),
      )));
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskBloc>(
          create: (context) => TaskBloc(),
        ),
        BlocProvider<SwitchBloc>(
          create: (context) => SwitchBloc(),
        ),
      ],
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Tasks App',
            theme: state.switchValue
                ? AppThemes.appThemeData[AppTheme.darkTheme]
                : AppThemes.appThemeData[AppTheme.lightTheme],
            home: const TasksScreen(),
            onGenerateRoute: appRouter.onGeneratRoute,
          );
        },
      ),
    );
  }
}
