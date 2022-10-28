import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_test_app/mockTestList/bloc/mock_test_list_bloc.dart';
import 'package:mock_test_app/mockTestList/mock_test_list_screen.dart';
import 'package:mock_test_app/repositories/mockTest/mock_test_repository.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: RepositoryProvider<MockTestRepository>(
        create: (context) => MockTestRepository(),
        child: BlocProvider<MockTestListBloc>(
          create: (context) =>
              MockTestListBloc(context.read<MockTestRepository>()),
          child: const MockTestListScreen(),
        ),
      ),
    );
  }

  const App({super.key});
}
