class LectureAPI {
  late final List<Lectures1> Lectures;

  LectureAPI({
    required this.Lectures,
  });

  LectureAPI.fromJson(Map<String, dynamic> json) {
    Lectures =
        List.from(json['Lectures']).map((e) => Lectures1.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Lectures'] = Lectures.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Lectures1 {
  Lectures1({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.note,
    required this.attendanceTaken,
    required this.batch,
    required this.subject,
  });
  late final int id;
  late final String startTime;
  late final String endTime;
  late final String date;
  late final String note;
  late final bool attendanceTaken;
  late final Batch batch;
  late final Subject subject;

  Lectures1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    date = json['date'];
    note = json['note'];
    attendanceTaken = json['attendance_taken'];
    batch = Batch.fromJson(json['batch']);
    subject = Subject.fromJson(json['subject']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['startTime'] = startTime;
    _data['endTime'] = endTime;
    _data['date'] = date;
    _data['note'] = note;
    _data['attendance_taken'] = attendanceTaken;
    _data['batch'] = batch.toJson();
    _data['subject'] = subject.toJson();
    return _data;
  }
}

class Batch {
  Batch({
    required this.id,
    required this.semester,
    required this.year,
    required this.name,
    required this.numberOfStudents,
  });
  late final int id;
  late final int semester;
  late final int year;
  late final String name;
  late final int numberOfStudents;

  Batch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    semester = json['semester'];
    year = json['year'];
    name = json['name'];
    numberOfStudents = json['number_of_students'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['semester'] = semester;
    _data['year'] = year;
    _data['name'] = name;
    _data['number_of_students'] = numberOfStudents;
    return _data;
  }
}

class Subject {
  Subject({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}
