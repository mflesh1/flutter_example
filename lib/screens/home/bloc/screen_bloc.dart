import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class ScreenBloc extends Bloc<ScreenEvent, ScreenState> {

  @override
  ScreenState get initialState => InitialScreenState();

  @override
  Stream<ScreenState> mapEventToState(ScreenEvent event) async* {
    if (event is ScreenRefreshEvent) {
      yield RefreshScreenState();
    }
  }

}

// States
abstract class ScreenState extends Equatable {
  const ScreenState();

  @override
  List<Object> get props => [];
}

class InitialScreenState extends ScreenState {

}

class RefreshScreenState extends ScreenState {

}

// events
abstract class ScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ScreenRefreshEvent extends ScreenEvent {}
