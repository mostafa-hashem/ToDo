import 'package:flutter/material.dart';
import 'package:todo/screens/done_tasks.dart';
import 'package:todo/screens/tasks.dart';

class BottomNavBarProvider extends ChangeNotifier {
  int index = 0;
  List<Widget> tabs = [
    TaskTab(),
     DoneTasks(),
  ];
  onTap(value){
    index = value;
    notifyListeners();
  }
}
