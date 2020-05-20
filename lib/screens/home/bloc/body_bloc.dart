import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_example/config/injection.dart';
import 'package:flutter_example/models/barrel.dart';
import 'package:flutter_example/repositories/app_exception.dart';
import 'package:flutter_example/repositories/barrel.dart';


class BodyBloc extends Bloc<BodyEvent, BodyState> {

  final DataRepository dataRepository;
  final MessageRepository messageRepository;

  BodyBloc({DataRepository dataRepository, MessageRepository messageRepository}) :
        dataRepository = dataRepository ?? locator<DataRepository>(),
        messageRepository = messageRepository ?? locator<MessageRepository>();


  @override
  BodyState get initialState => InitialBodyState();

  @override
  Stream<BodyState> mapEventToState(BodyEvent event) async* {
    if (event is LoadBody) {
      yield* _mapLoadBody(event);
    }
  }

  Stream<BodyState> _mapLoadBody(LoadBody event) async* {
    yield LoadingBodyState();
    try {
      List messages = await messageRepository.getAll();
      yield LoadedBodyState(messages);
    } on AppException catch (e) {
      yield LoadBodyFailed(e.getMessage());
    }
  }

}

// States
abstract class BodyState extends Equatable {
  const BodyState();

  @override
  List<Object> get props => [];
}

class InitialBodyState extends BodyState {

}

class LoadingBodyState extends BodyState {}

class LoadedBodyState extends BodyState {
  final List<Message> messages;

  LoadedBodyState(this.messages);
}

class LoadBodyFailed extends BodyState {
  final String message;

  LoadBodyFailed(this.message);

  @override
  List<Object> get props => [message];
}

// events
abstract class BodyEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadBody extends BodyEvent {}
