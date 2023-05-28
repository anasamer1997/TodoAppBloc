import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/screens/recycle_bin.dart';

import '../screens/tabsScreen.dart';

class AppRouter {
  Route? onGeneratRoute(RouteSettings settings) {
    switch (settings.name) {
      case RecycleBin.id:
        return MaterialPageRoute(builder: ((_) => const RecycleBin()));
      case TabsScreen.id:
        return MaterialPageRoute(builder: ((_) =>  TabsScreen()));
      default:
        return null;
    }
  }
}
