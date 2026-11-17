import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/counter_cubit.dart';
import '../cubit/counter_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Cubit Counter')),
    body: Center(
      child: Column(
        children: [
          BlocBuilder<CounterCubit, CounterState>(builder: (context, state) {
            return Text("Count ${state.count}");

          },),
          ElevatedButton(onPressed: (){
            context.read<CounterCubit>().increment();
          }, child: Text("Increment")),
          ElevatedButton(onPressed: (){
            context.read<CounterCubit>().decrement();
          }, child: Text("Decrement")),
        ],
      ),
    ),
  );
  }
}