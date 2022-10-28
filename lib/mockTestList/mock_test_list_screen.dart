import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_test_app/createMockTest/bloc/create_mock_test_bloc.dart'
    hide ErrorState;
import 'package:mock_test_app/createMockTest/create_mock_test_screen.dart';
import 'package:mock_test_app/mockTestList/bloc/mock_test_list_bloc.dart';
import 'package:mock_test_app/repositories/mockTest/mock_test_repository.dart';
import 'package:mock_test_app/repositories/mockTest/models/mock_test.dart';

class MockTestListScreen extends StatefulWidget {
  const MockTestListScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MockTestListScreenState();
  }
}

class _MockTestListScreenState extends State<MockTestListScreen> {
  late MockTestRepository _repo;

  @override
  void initState() {
    _repo = context.read<MockTestRepository>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _titleAndLogo(),
          _createTestButton(),
          const Divider(
            height: 1,
            color: Colors.blue,
          ),
          _mockTestList()
        ],
      ),
    );
  }

  _titleAndLogo() {
    return Column(
      children: const [
        Text('Mock Test App'),
        SizedBox(
          height: 12,
        ),
        Icon(
          Icons.code,
          size: 100,
        )
      ],
    );
  }

  _createTestButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return BlocProvider<CreateMockTestBloc>(
                  create: (context) {
                    return CreateMockTestBloc(_repo);
                  },
                  child: const CreateMockTestScreen(),
                );
              },
            ));
          },
          style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Create New Test',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  _mockTestList() {
    return Expanded(
      child: BlocBuilder<MockTestListBloc, MockTestListState>(
        builder: (context, state) {
          if (state is ListLoadedState) {
            return ListView.builder(
              itemCount: state.list.length,
              itemBuilder: (context, index) =>
                  _MockTestListItem(state.list[index]),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            );
          }
          if (state is ErrorState) {
            return Center(
              child: Text(state.error),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class _MockTestListItem extends StatelessWidget {
  final MockTest mockTest;

  const _MockTestListItem(this.mockTest);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueGrey.shade100, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                mockTest.testName ?? '',
                textAlign: TextAlign.left,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                mockTest.createdAt ?? '',
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
