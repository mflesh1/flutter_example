import 'package:flutter_example/utils/json_helper.dart';

class Message {
  final String id;
  final String from;
  final String message;
  final DateTime date;

  Message(this.id, this.from, this.message, this.date);


  static Message fromJson(dynamic json) {
    if (json == null) {
      return null;
    }

    String id = JsonHelper.asString(json["id"]);
    String message = JsonHelper.asString(json["message"]);
    String from = JsonHelper.asString(json["from"]);
    DateTime date = JsonHelper.asDateTime(json["date"]);

    return Message(id, from, message, date);
  }
}