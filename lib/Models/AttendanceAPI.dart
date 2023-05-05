class AttendanceAPI {
  AttendanceAPI({
    required this.present,
    required this.lecture,
    required this.student,
  });
  late final bool present;
  late final int lecture;
  late final int student;

  AttendanceAPI.fromJson(Map<String, dynamic> json){
    present = json['present'];
    lecture = json['lecture'];
    student = json['student'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['present'] = present;
    _data['lecture'] = lecture;
    _data['student'] = student;
    return _data;
  }
}