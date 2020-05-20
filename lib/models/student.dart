import 'package:equatable/equatable.dart';
import 'package:flutter_example/utils/json_helper.dart';

class Student extends Equatable {

  final String id;
  final String name;
  final String studentId;
  final String schoolName;

  const Student({this.id, this.name, this.studentId, this.schoolName});

  @override
  List<Object> get props => [id];

  static Student fromJson(dynamic json) {
    if (json == null || json == "") {
      return null;
    }
    if (json['id']==null) {
      return null;
    }

    return Student(
      id: JsonHelper.asString(json['id']),
      name: JsonHelper.asString(json['name']),
      studentId : JsonHelper.asString(json['studentId']),
      schoolName : JsonHelper.asString(json['schoolName']),
    );
  }

  @override
  String toString() => 'Student { id: $id }';

}