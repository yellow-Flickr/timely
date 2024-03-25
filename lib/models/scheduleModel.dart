// Enum Priority

class ScheduleModel {
  final int id;
  final String title;
  final String notes;
  final Duration repeat;
  final int priority;

  ScheduleModel(this.id, this.title, this.notes, this.repeat, this.priority);
}

ScheduleModel testSchedule = ScheduleModel(0, 'Pomodoro Workout',
    '10 Burpees, 30 Squats, 20 Lunges', const Duration(hours: 1), 1);

