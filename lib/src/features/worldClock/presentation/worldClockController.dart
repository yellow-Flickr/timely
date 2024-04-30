import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WorldClockStates with ChangeNotifier {
  String _timezone = '';
  final List<String> _timezones = [];

  String get timezone => _timezone;
  List<String> get timezones => _timezones;

  set timezone(String timezone) {
    _timezone = timezone;
  }

  void addTimezone(String zone) {
    _timezones.add(zone);
    notifyListeners();
  }

  void clearTimezones() {
    _timezones.clear();
    notifyListeners();
  }

  void removeTimezone(String zone) {
    _timezones.remove(zone);
    notifyListeners();
  }
}
