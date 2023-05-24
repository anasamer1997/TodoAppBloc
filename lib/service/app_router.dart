import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/screens/recycle_bin.dart';
import 'package:flutter_tasks_app/screens/tasks_screen.dart';

class AppRouter {
  Route? onGeneratRoute(RouteSettings settings) {
    switch (settings.name) {
      case RecycleBin.id:
        return MaterialPageRoute(builder: ((_) => const RecycleBin()));
      case TasksScreen.id:
        return MaterialPageRoute(builder: ((_) => const TasksScreen()));
      default:
        return null;
    }
  }
}
