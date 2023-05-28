import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tasks_app/bloc/bloc_export.dart';
import 'package:flutter_tasks_app/screens/tabsScreen.dart';
import 'package:flutter_tasks_app/service/app_router.dart';
import 'package:flutter_tasks_app/service/app_theme.dart';

import 'screens/pendingTaskScreen.dart';

void main() async {
  // ignore: deprecated_member_use
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
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
            home:  TabsScreen(),
            onGenerateRoute: appRouter.onGeneratRoute,
          );
        },
      ),
    );
  }
}
