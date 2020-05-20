import 'package:equatable/equatable.dart';

abstract class ScreenEvent extends Equatable {

  @override
  List<Object> get props => [];

}

class GetStudents extends ScreenEvent {

}

class DeleteStudent extends ScreenEvent {
  final String studentId;

  DeleteStudent(this.studentId);

  @override
  List<Object> get props => [studentId];
}