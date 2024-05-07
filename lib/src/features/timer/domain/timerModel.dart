
class TimerModel {
  final int id;
  final String title;
   final Duration countDown;
 
  TimerModel(
      {required this.id,
      required this.title,
       this.countDown = const Duration(hours: 1),
       });

       TimerModel.empty():this(id: -1,title: '',countDown: Duration.zero);
}

List<TimerModel> testSchedule = [
  TimerModel(
      id: 0,
      title: 'Pomodoro Workout',
      
      countDown: const Duration(hours: 1),
      
      ),
  TimerModel(
      id: 0,
      title: 'Pomodoro Workout',
      
      countDown: const Duration(hours: 1),
      
      ),
  TimerModel(
      id: 0,
      title: 'Pomodoro Workout',
      
      countDown: const Duration(hours: 1),
      
      ),
  TimerModel(
      id: 0,
      title: 'Pomodoro Workout',
      
      countDown: const Duration(hours: 1),
      
      ),
  TimerModel(
      id: 0,
      title: 'Pomodoro Workout',
      
      countDown: const Duration(hours: 1),
      
      ),
  TimerModel(
      id: 0,
      title: 'Pomodoro Workout',
      
      countDown: const Duration(hours: 1),
      
      ),
  TimerModel(
      id: 0,
      title: 'Pomodoro Workout',
      
      countDown: const Duration(hours: 1),
      
      ),
  TimerModel(
      id: 0,
      title: 'Pomodoro Workout',
      
      countDown: const Duration(hours: 1),
      
      ),
  TimerModel(
      id: 0,
      title: 'Pomodoro Workout',
      
      countDown: const Duration(hours: 1),
      
      ),
];
