import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:timely/src/features/timer/domain/timerModel.dart';

class TimerStates with ChangeNotifier {
  TimerModel _timer = TimerModel.empty();
  final List<TimerModel> _timers = [  TimerModel(
      id: 0,
      title: 'Pomodoro Workout',
      
      countDown: const Duration(hours: 1),
      
      ),
  TimerModel(
      id: 0,
      title: 'Pomodoro Workout',
      
      countDown: const Duration(hours: 1),
      
      ),];

  TimerModel get timer => _timer;
  List<TimerModel> get timers => _timers;

  set timer(TimerModel timer) {
    _timer = timer;
  }

  void addtimer(TimerModel zone) {
    _timers.add(zone);
    notifyListeners();
  }

  void clearTimers() {
    _timers.clear();
    notifyListeners();
  }

  void removeTimer(TimerModel zone) {
    _timers.remove(zone);
    notifyListeners();
  }
}
