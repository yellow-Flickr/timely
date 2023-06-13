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

import 'dart:developer';

import 'package:flutter/material.dart';

class ViewModel {
  // ViewModel({this.starter  ,  this.timing});
  ValueNotifier<bool> starter = ValueNotifier(false);
  ValueNotifier<int> timing = ValueNotifier(0);

  void status(bool _status) {
    starter.value = _status;
    // log('message');
    starter.notifyListeners();
  }

  void time(int _time) {
    timing.value = _time;
    timing.notifyListeners();
  }
}

// void main() => runApp(new MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return   MaterialApp(
//       title: 'Flutter Demo',
//       theme:   ThemeData(
//           primarySwatch: Colors.deepPurple,
//           textTheme: TextTheme(
//               bodyText2: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold))),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   Engine _engine;

//   @override
//   void initState() {
//     _engine = Engine();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _engine.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("ValueListenableBuilder"),
//         ),
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               color: Colors.red,
//               width: double.infinity,
//               height: 100,
//               child: Center(
//                   child: ValueListenableBuilder<int>(
//                       valueListenable: _engine.incrementvalue,
//                       builder: (context, value, _) {
//                         return Text('INC $value');
//                       })),
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     height: 100,
//                     color: Colors.green,
//                     child: Center(
//                         child: ValueListenableBuilder<int>(
//                             valueListenable: _engine.decrementValue,
//                             builder: (context, value, _) {
//                               return Text('DEC $value');
//                             })),
//                   ),
//                 ),
//                 Expanded(
//                   child: Container(
//                     height: 100,
//                     color: Colors.blue,
//                     child: Center(
//                         child: ValueListenableBuilder<int>(
//                             valueListenable: _engine.incrementvalue,
//                             builder: (context, value, _) {
//                               return ValueListenableBuilder<int>(
//                                   valueListenable: _engine.decrementValue,
//                                   builder: (context, value2, _) {
//                                     return Text(
//                                         'INC : $value  / DEC : $value2');
//                                   });
//                             })),
//                   ),
//                 )
//               ],
//             ),
//             Expanded(
//               child: ValueListenableBuilder<Color>(
//                   valueListenable: _engine.color,
//                   builder: (context, color, _) => Container(
//                         width: 200,
//                         color: color,
//                         child: ValueListenableBuilder<int>(
//                             valueListenable: _engine.incrementvalue,
//                             builder: (context, inc, _) =>
//                                 ValueListenableBuilder(
//                                     valueListenable: _engine.decrementValue,
//                                     builder: (context, dec, _) => Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Text('Increment $inc '),
//                                             SizedBox(
//                                               height: 50,
//                                             ),
//                                             Text('Decrement $dec '),
//                                           ],
//                                         ))),
//                       )),
//             )
//           ],
//         ),
//         floatingActionButton: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             FloatingActionButton(
//               onPressed: _engine.increment,
//               child: const Text("INC"),
//             ),
//             FloatingActionButton(
//               onPressed: _engine.decrement,
//               child: Text("DEC"),
//             ),
//             FloatingActionButton(
//               onPressed: _engine.randomColor,
//               child: Text("COLOR"),
//             ),
//             FloatingActionButton(
//               onPressed: () {
//                 _engine.increment();
//                 _engine.decrement();
//                 _engine.randomColor();
//               },
//               child: Text("ALL"),
//             )
//           ],
//         ));
//   }
// }

// class Engine {
//   ValueNotifier<int> incrementvalue = ValueNotifier(1);
//   ValueNotifier<int> decrementValue = ValueNotifier(100);
//   ValueNotifier<Color> color = ValueNotifier(Colors.black);

//   void increment() {
//     incrementvalue.value = incrementvalue.value + 1;
//   }

//   void decrement() {
//     decrementValue.value--;
//   }

//   void randomColor() {
//     color.value = Colors.primaries[Random().nextInt(Colors.primaries.length)];
//   }

//   void dispose() {
//     incrementvalue.dispose();
//     decrementValue.dispose();
//     color.dispose();
//   }
// }
