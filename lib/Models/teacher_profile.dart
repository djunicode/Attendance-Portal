import "package:flutter/material.dart";

class TeacherProfile {
  TeacherProfile({
    required this.id,
    required this.specialization,
    required this.user,
    required this.subjects,
  });
  late final int id;
  late final String specialization;
  late final User user;
  late final List<Subjects> subjects;

  TeacherProfile.fromJson(Map<String, dynamic> json){
    id = json['id'];
    specialization = json['specialization'];
    user = User.fromJson(json['user']);
    subjects = List.from(json['subjects']).map((e)=>Subjects.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['specialization'] = specialization;
    _data['user'] = user.toJson();
    _data['subjects'] = subjects.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.sapId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
  });
  late final int id;
  late final int sapId;
  late final String firstName;
  late final String middleName;
  late final String lastName;

  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    sapId = json['sap_id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['sap_id'] = sapId;
    _data['first_name'] = firstName;
    _data['middle_name'] = middleName;
    _data['last_name'] = lastName;
    return _data;
  }
}

class Subjects {
  Subjects({
    required this.id,
    required this.name,
    required this.semester,
    required this.department,
  });
  late final int id;
  late final String name;
  late final int semester;
  late final Department department;

  Subjects.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    semester = json['semester'];
    department = Department.fromJson(json['department']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['semester'] = semester;
    _data['department'] = department.toJson();
    return _data;
  }
}

class Department {
  Department({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  Department.fromJson(Map<String, dynamic> json){
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