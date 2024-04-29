import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TimelyStates with ChangeNotifier {
  List<(Duration, Duration)> _laps = [];
  Duration _overallTimer = Duration.zero;

  List<(Duration, Duration)> get laps => _laps;
  Duration get overallTimer => _overallTimer;

  set laps(List<(Duration, Duration)> laps) {
    _laps = laps;
  }

  set overallTimer(Duration timer) {
    _overallTimer = timer;
  }


  void addLap((Duration, Duration) lap) {
    _laps.add(lap);
    notifyListeners();
  }

  void clearLaps() {
    _laps.clear();
    notifyListeners();
  }
}

String lapOutputFormat(Duration duration) {
  return "${duration.inMinutes.ceil().toString().padLeft(2, '0')}:${(duration.inSeconds.ceil() % Duration.secondsPerMinute).toString().padLeft(2, '0')}.${(duration.inMilliseconds.ceil() % Duration.millisecondsPerSecond).toString().padLeft(3, '0')}";
}
