enum Priority { High, Medium, Low }

class ScheduleModel {
  final int id;
  final String title;
  final String notes;
  final Duration repeat;
  final Priority priority;
  final bool active;

  ScheduleModel(
      this.id, this.title, this.notes, this.repeat, this.priority, this.active);
}

List<ScheduleModel> testSchedule = [
  ScheduleModel(0, 'Pomodoro Workout', '10 Burpees, 30 Squats, 20 Lunges',
      const Duration(hours: 1), Priority.High, false),
  ScheduleModel(0, 'Pomodoro Workout', '10 Burpees, 30 Squats, 20 Lunges',
      const Duration(hours: 1), Priority.High, false),
  ScheduleModel(0, 'Pomodoro Workout', '10 Burpees, 30 Squats, 20 Lunges',
      const Duration(hours: 1), Priority.High, true),
  ScheduleModel(0, 'Pomodoro Workout', '10 Burpees, 30 Squats, 20 Lunges',
      const Duration(hours: 1), Priority.High, false),
  ScheduleModel(0, 'Pomodoro Workout', '10 Burpees, 30 Squats, 20 Lunges',
      const Duration(hours: 1), Priority.High, true),
  ScheduleModel(0, 'Pomodoro Workout', '10 Burpees, 30 Squats, 20 Lunges',
      const Duration(hours: 1), Priority.High, false),
  ScheduleModel(0, 'Pomodoro Workout', '10 Burpees, 30 Squats, 20 Lunges',
      const Duration(hours: 1), Priority.High, true),
];
