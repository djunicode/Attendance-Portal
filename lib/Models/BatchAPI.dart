class BatchAPI {
  BatchAPI({
    required this.id,
    required this.semester,
    required this.year,
    required this.name,
    required this.numberOfStudents,
    required this.classTeacher,
    required this.department,
  });
  late final int id;
  late final int semester;
  late final int year;
  late final String name;
  late final int numberOfStudents;
  late final String classTeacher;
  late final String department;

  BatchAPI.fromJson(Map<String, dynamic> json){
    id = json['id'];
    semester = json['semester'];
    year = json['year'];
    name = json['name'];
    numberOfStudents = json['number_of_students'];
    classTeacher = json['class_teacher'];
    department = json['department'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['semester'] = semester;
    _data['year'] = year;
    _data['name'] = name;
    _data['number_of_students'] = numberOfStudents;
    _data['class_teacher'] = classTeacher;
    _data['department'] = department;
    return _data;
  }
}