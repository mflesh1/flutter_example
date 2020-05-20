import 'package:flutter_example/models/student.dart';

abstract class StudentRepository {

  Future<Student> getStudent(String customerId, String studentNumber, String firstName, String lastInitial);
  Future<void> addStudent(String studentId);
  Future<List<Student>> getStudents();
  Future<List<Student>> delete(String studentId);
  Future<Student> get(String studentId);
  Future<Student> update(Student student);

}