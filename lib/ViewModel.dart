// class ViewModel extends ChangeNotifier {
//   bool _starter = false;
//   int _timing = 0;

//   bool get starter => _starter;
//   int get timing => _timing;

//   set starter(bool _start) {
//     _starter = _start;
//     notifyListeners();
//   }

//   set timing(int _time) {
//     _timing = _time;
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';

class ViewModel {
  // ViewModel({this.starter  ,  this.timing});
  ValueNotifier<bool> starter = ValueNotifier(false);
  ValueNotifier<int> timing = ValueNotifier(0);

  void status(bool _status) {
    starter.value = _status;
    starter.notifyListeners();
  }

  void time(int _time) {
    timing.value = _time;
    timing.notifyListeners();
  }
}
