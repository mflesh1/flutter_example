import 'package:equatable/equatable.dart';

import 'barrel.dart';

class User extends Equatable {

  final String name;
  final String token;
  final int numberOfStudents;

  const User({this.name, this.token,this.numberOfStudents = 0});

  bool hasStudents() {
    if (numberOfStudents == null) {
      return false;
    }
    return numberOfStudents > 0;
  }

  @override
  List<Object> get props => [name, token, numberOfStudents];

  static User fromJson(dynamic json) {

    return User(
      name: json['name'],
      token: json['token'],
      numberOfStudents: json['numberOfStudents'],
    );

  }

  Map toJson() {
    return {
      'name': name,
      'token': token,
      'numberOfStudents' : numberOfStudents,
    };
  }

  @override
  String toString() => 'User { name: $name }';

}

enum LoginType {
  APPLICATION,GOOGLE
}