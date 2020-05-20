import 'package:flutter_example/models/barrel.dart';

abstract class MessageRepository {
  Future<List<Message>> getAll();
  Future<Message> getOne(String messageId);
}