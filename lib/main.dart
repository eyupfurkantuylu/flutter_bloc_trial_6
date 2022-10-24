import 'dart:io';

import 'package:bloc2bloc/blocs/color/color_bloc.dart';
import 'package:bloc2bloc/blocs/counter/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ColorBloc>(
          create: (context) => ColorBloc(),
        ),
        BlocProvider<CounterBloc>(
          create: (context) =>
              CounterBloc(colorBloc: context.read<ColorBloc>()),
        ),
      ],
      child: MaterialApp(
        title: 'bloc2bloc',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Bloc to Bloc'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ColorBloc>().state.color,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                context.read<ColorBloc>().add(ChangeColorEvent());
              },
              child: const Text(
                'Change Color',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              '${context.watch<CounterBloc>().state.counter}',
              style: const TextStyle(
                fontSize: 52.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<CounterBloc>().add(ChangeCountEvent());
              },
              child: const Text(
                'Increment Counter',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
