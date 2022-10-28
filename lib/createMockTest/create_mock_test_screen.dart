import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_test_app/createMockTest/bloc/create_mock_test_bloc.dart';
import 'package:mock_test_app/createMockTest/widgets/topic_selection_list.dart';

import '../repositories/mockTest/models/topic.dart';

class CreateMockTestScreen extends StatefulWidget {
  const CreateMockTestScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CreateMockTestScreenState();
  }
}

class _CreateMockTestScreenState extends State<CreateMockTestScreen> {
  final TextEditingController _nameController = TextEditingController();
  List<Topic> availableTopics = [];

  Map<String, List<String>> selectedTopics = {};

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CreateMockTestBloc>().add(const TopicListRequestedEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Create New Test',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [_testNameFiled(), _topicsList()],
        ),
      ),
    );
  }

  _testNameFiled() {
    return Padding(
      padding: const EdgeInsets.only(bottom:  12.0),
      child: TextField(
        controller: _nameController,
        decoration: InputDecoration(
            label: const Text('Test Name'),
            prefixIcon: const Icon(
              Icons.contact_page_outlined,
              color: Colors.blue,
            ),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      ),
    );
  }

  _topicsList() {
    return Expanded(
      child: BlocConsumer<CreateMockTestBloc, CreateMockTestState>(
        builder: (context, state) {
          if (state is TopicsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is TopicsLoadingErrorState) {
            return Center(
              child: Text(state.error),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Topics',
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
              Expanded(
                child: TopicSelectionList(
                  availableTopics: availableTopics,
                  onSelectionChanged: (topics) {
                    selectedTopics = topics;
                  },
                ),
              ),
              _createButton(),
            ],
          );
        },
        listener: (context, state) {
          if (state is MockTestCreatedState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Test created successfully')));
            Navigator.of(context).pop();
          }

          if (state is ErrorState) {

            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
          if (state is TopicsLoadedState) {
            availableTopics = state.list;
            setState(() {});
          }
        },
      ),
    );
  }

  _createButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: () async {
            List<Topic> list = [];
            selectedTopics.forEach((key, value) {
              list.add(Topic(topicName: key, concepts: value));
            });
            context
                .read<CreateMockTestBloc>()
                .add(CreateTestEvent(name: _nameController.text, topics: list));
          },
          style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Create',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
