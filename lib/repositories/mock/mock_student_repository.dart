import 'package:flutter_example/models/student.dart';
import 'package:flutter_example/repositories/student_repository.dart';

class MockStudentRepository implements StudentRepository {

  Map<String, Student> students = {};

  MockStudentRepository() {
    students.putIfAbsent("1", () => Student(name: "John Doe", id: "1", schoolName: "High School", studentId: "123456"));
  }

  @override
  Future<Student> getStudent(String customerId, String studentNumber, String firstName, String lastInitial) {
    Student student = Student(id: "1", name: "Full Name", studentId: "12323", schoolName: "School Name");
    return Future.delayed(
      Duration(seconds: 1),
          () {
        if (firstName.toLowerCase() == "first") {
          return student;
        } else {
          return null;
        }
      },
    );
  }

  @override
  Future<void> addStudent(String studentId) {
    return Future.delayed(
      Duration(seconds: 1),
          () {
        return;
      },
    );
  }

  @override
  Future<List<Student>> delete(String studentId) {
    return Future.delayed(
      Duration(seconds: 1),
          () {
        return students.values.toList();
      },
    );
  }

  @override
  Future<List<Student>> getStudents() {
    return Future.delayed(
      Duration(seconds: 1),
          () {
        return students.values.toList();
      },
    );
  }

  @override
  Future<Student> get(String studentId) {
    return Future.delayed(
      Duration(seconds: 1),
          () {
        return students[studentId];
      },
    );
  }

  @override
  Future<Student> update(Student student) {
    // TODO: implement update
    return null;
  }

}