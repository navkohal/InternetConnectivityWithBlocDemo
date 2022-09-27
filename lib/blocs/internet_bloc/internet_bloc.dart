import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'internet_event.dart';
import 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  // InternetBloc(super.initialState);

  //third party library to listen internet connectivity in pubspec.yaml
  Connectivity _connectivity = Connectivity();

  //to cancel connectivity listener after screen & bloc is destroyed
  StreamSubscription? connectivitySubscription;

  InternetBloc() : super(InternetInitialState()) {
    on<InternetConnectedEvent>((event, emit) => emit(InternetConnectedState()));
    on<InternetDisconnectedEvent>((event, emit) => emit(InternetLostState()));

    connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        add(InternetConnectedEvent());
      } else {
        add(InternetDisconnectedEvent());
      }
    });
  }

  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}
