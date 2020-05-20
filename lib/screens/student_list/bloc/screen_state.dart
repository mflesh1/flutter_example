import 'package:equatable/equatable.dart';
import 'package:flutter_example/models/barrel.dart';
import 'package:flutter_example/models/student.dart';

abstract class ScreenState extends Equatable {

  const ScreenState();

  @override
  List<Object> get props => [];

}

class InitialState extends ScreenState{}

class FetchingStudents extends ScreenState{}

class FetchedStudents extends ScreenState{
  final List<Student> students;
  final String error;

  FetchedStudents(this.students, this.error);

  @override
  List<Object> get props => [this.students, this.error];
}

class DeleteStudentFailed extends ScreenState {
  final String error;

  DeleteStudentFailed(this.error);

  @override
  List<Object> get props => [error];
}