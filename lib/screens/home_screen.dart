import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc_example/blocs/internet_bloc/internet_bloc.dart';
import 'package:login_bloc_example/blocs/internet_bloc/internet_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: BlocConsumer<InternetBloc, InternetState>(
            listener: (context, state) {
              if(state is InternetConnectedState){
                ScaffoldMessenger.of(context).
                showSnackBar(SnackBar(content: Text('CONNECTED')));
              }else if(state is InternetLostState){
                ScaffoldMessenger.of(context).
                showSnackBar(SnackBar(content: Text('DISCONNECTED')));
              }
            },
            builder: (context, state) {
              return BlocBuilder<InternetBloc, InternetState>(
                builder: (context, state) {
                  if (state is InternetConnectedState) {
                    return Text('Internet Connected');
                  } else if (state is InternetLostState) {
                    return Text('Internet Lost');
                  } else {
                    return Text('Loading.....');
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
