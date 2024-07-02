import 'package:timely/src/features/scheduler/domain/scheduleModel.dart';

abstract class ScheduleRepository {
  Future<void> addSchedule(ScheduleModel schedule);
  Future<List<ScheduleModel>> loadAllSchedules();
  Future<void> updateSchedule(ScheduleModel schedule);
  Future<void> deleteSchedule(ScheduleModel schedule);
}


class LocalScheduleStore implements ScheduleRepository {
  @override
  Future<void> addSchedule(ScheduleModel schedule) {
    // TODO: implement addSchedule
    throw UnimplementedError();
  }

  @override
  Future<void> deleteSchedule(ScheduleModel schedule) {
    // TODO: implement deleteSchedule
    throw UnimplementedError();
  }

  @override
  Future<List<ScheduleModel>> loadAllSchedules() {
    // TODO: implement loadAllSchedules
    throw UnimplementedError();
  }

  @override
  Future<void> updateSchedule(ScheduleModel schedule) {
    // TODO: implement updateSchedule
    throw UnimplementedError();
  }
  
}


