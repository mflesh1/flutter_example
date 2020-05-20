import 'package:bloc/bloc.dart';
import 'package:flutter_example/config/injection.dart';
import 'package:flutter_example/models/barrel.dart';
import 'package:flutter_example/repositories/barrel.dart';

import 'barrel.dart';

class ScreenBloc extends Bloc<ScreenEvent, ScreenState> {

  final StudentRepository studentRepository;

  ScreenBloc({StudentRepository studentRepository})
      : studentRepository = studentRepository ?? locator<StudentRepository>();

  @override
  ScreenState get initialState => InitialState();

  @override
  Stream<ScreenState> mapEventToState(ScreenEvent event) async* {
    if (event is GetStudents) {
      yield* _mapGetStudents(event);
    } else if (event is DeleteStudent) {
      yield* _mapDeleteStudent(event);
    }
  }

  Stream<ScreenState> _mapGetStudents(GetStudents event) async* {
    yield FetchingStudents();
    try {
      List<Student> items = await studentRepository.getStudents();
      yield FetchedStudents(items, null);
    } on AppException catch (e) {
      yield FetchedStudents(null, e.getMessage());
    }
  }

  Stream<ScreenState> _mapDeleteStudent(DeleteStudent event) async* {
    yield FetchingStudents();
    try {
      List<Student> items = await studentRepository.delete(event.studentId);
      yield FetchedStudents(items, null);
    } on AppException catch (e) {
      yield DeleteStudentFailed(e.getMessage());
    }
  }
}
