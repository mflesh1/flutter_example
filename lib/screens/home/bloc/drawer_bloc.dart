import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_example/models/barrel.dart';
import 'package:flutter_example/repositories/barrel.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  final DataRepository dataRepository;
  final AccountRepository accountRepository;

  DrawerBloc({@required this.dataRepository, @required this.accountRepository});

  @override
  DrawerState get initialState => LoadingDrawerState();

  @override
  Stream<DrawerState> mapEventToState(DrawerEvent event) async* {
    if (event is LoadDrawer) {
      yield LoadingDrawerState();
      User user;
      try {
        user = await this.accountRepository.getUser();
        await this.dataRepository.setUser(user);
      } on AppException catch (e, stacktrace) {
        log(e.getMessage(), stackTrace: stacktrace);
      } catch (error) {
        log(error);
      }
      if (user == null) {
        user = await this.dataRepository.getUser();
      }
      yield LoadedDrawerState(user);
    }
  }
}

// States
abstract class DrawerState extends Equatable {
  const DrawerState();

  @override
  List<Object> get props => [];
}

class LoadingDrawerState extends DrawerState {}

class LoadedDrawerState extends DrawerState {
  final User user;

  LoadedDrawerState(this.user);

  @override
  List<Object> get props => [user];
}

class LoadDrawerFailureState extends DrawerState {
  final int code;
  final String message;

  LoadDrawerFailureState(this.code, this.message);

  @override
  List<Object> get props => [code, message];
}

// events
abstract class DrawerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadDrawer extends DrawerEvent {}
