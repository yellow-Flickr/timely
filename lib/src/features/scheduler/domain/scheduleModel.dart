enum Priority { High, Medium, Low }

class ScheduleModel {
  final int id;
  final String title;
  final String notes;
  final Duration repeat;
  final Priority priority;
  final bool active;

  ScheduleModel(
      {required this.id,
      required this.title,
      required this.notes,
      this.repeat = const Duration(hours: 1),
      this.priority = Priority.Low,
      this.active = false});
}

List<ScheduleModel> testSchedule = [
  ScheduleModel(
      id: 0,
      title: 'Pomodoro Workout',
      notes: '10 Burpees, 30 Squats, 20 Lunges',
      repeat: const Duration(hours: 1),
      priority: Priority.High,
      active: false),
  ScheduleModel(
      id: 0,
      title: 'Pomodoro Workout',
      notes: '10 Burpees, 30 Squats, 20 Lunges',
      repeat: const Duration(hours: 1),
      priority: Priority.High,
      active: true),
  ScheduleModel(
      id: 0,
      title: 'Pomodoro Workout',
      notes: '10 Burpees, 30 Squats, 20 Lunges',
      repeat: const Duration(hours: 1),
      priority: Priority.High,
      active: false),
  ScheduleModel(
      id: 0,
      title: 'Pomodoro Workout',
      notes: '10 Burpees, 30 Squats, 20 Lunges',
      repeat: const Duration(hours: 1),
      priority: Priority.High,
      active: true),
  ScheduleModel(
      id: 0,
      title: 'Pomodoro Workout',
      notes: '10 Burpees, 30 Squats, 20 Lunges',
      repeat: const Duration(hours: 1),
      priority: Priority.High,
      active: false),
  ScheduleModel(
      id: 0,
      title: 'Pomodoro Workout',
      notes: '10 Burpees, 30 Squats, 20 Lunges',
      repeat: const Duration(hours: 1),
      priority: Priority.High,
      active: true),
  ScheduleModel(
      id: 0,
      title: 'Pomodoro Workout',
      notes: '10 Burpees, 30 Squats, 20 Lunges',
      repeat: const Duration(hours: 1),
      priority: Priority.High,
      active: false),
  ScheduleModel(
      id: 0,
      title: 'Pomodoro Workout',
      notes: '10 Burpees, 30 Squats, 20 Lunges',
      repeat: const Duration(hours: 1),
      priority: Priority.High,
      active: true),
  ScheduleModel(
      id: 0,
      title: 'Pomodoro Workout',
      notes: '10 Burpees, 30 Squats, 20 Lunges',
      repeat: const Duration(hours: 1),
      priority: Priority.High,
      active: false),
];
