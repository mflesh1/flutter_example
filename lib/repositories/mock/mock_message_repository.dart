import 'package:flutter_example/models/barrel.dart';
import 'package:flutter_example/repositories/message_repository.dart';

class MockMessageRepository implements MessageRepository {

  Map<String, Message> messages = {};

  MockMessageRepository() {
    for( var i = 1 ; i < 15; i++ ) {
      messages.putIfAbsent(i.toString(),()=>Message(i.toString(), "John Smith", "This is message $i.", DateTime.now().subtract(new Duration(hours: i))));
    }
  }
  
  @override
  Future<Message> getOne(String messageId) {
    return Future.delayed(
        Duration(seconds: 1),
            () {
          return messages[messageId];
        }
    );
  }

  @override
  Future<List<Message>> getAll() {
    return Future.delayed(
        Duration(seconds: 1),
            () {
          return messages.values.toList();
        }
    );
  }

}