class CreateLecture {
  String? roomNumber;
  String? startTime;
  String? endTime;
  String? date;
  String? note;
  bool? attendanceTaken;
  int? teacher;
  int? batch;
  int? subject;

  CreateLecture(
      {this.roomNumber,
        this.startTime,
        this.endTime,
        this.date,
        this.note,
        this.attendanceTaken,
        this.teacher,
        this.batch,
        this.subject});

  CreateLecture.fromJson(Map<String, dynamic> json) {
    roomNumber = json['room_number'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    date = json['date'];
    note = json['note'];
    attendanceTaken = json['attendance_taken'];
    teacher = json['teacher'];
    batch = json['batch'];
    subject = json['subject'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_number'] = this.roomNumber;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['date'] = this.date;
    data['note'] = this.note;
    data['attendance_taken'] = this.attendanceTaken;
    data['teacher'] = this.teacher;
    data['batch'] = this.batch;
    data['subject'] = this.subject;
    return data;
  }
}