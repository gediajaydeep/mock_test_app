import 'package:flutter/material.dart';
import 'package:mock_test_app/repositories/mockTest/models/topic.dart';

class TopicSelectionList extends StatefulWidget {
  final List<Topic> availableTopics;
  final Function(Map<String, List<String>>) onSelectionChanged;

  const TopicSelectionList(
      {super.key,
      required this.availableTopics,
      required this.onSelectionChanged});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TopicSelectionListState();
  }
}

class _TopicSelectionListState extends State<TopicSelectionList> {
  Map<String, List<String>> selectedTopics = {};

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemCount: widget.availableTopics.length,
      itemBuilder: (context, index) => _TopicChild(
        topic: widget.availableTopics[index],
        selectedConcepts:
            selectedTopics[widget.availableTopics[index].topicName] ?? [],
        onSelectionChanged: (selectedConcepts) {
          selectedTopics[widget.availableTopics[index].topicName!] =
              selectedConcepts!;
          widget.onSelectionChanged(selectedTopics);
          setState(() {});
        },
      ),
    );
  }
}

class _TopicChild extends StatelessWidget {
  final Topic topic;
  final List<String> selectedConcepts;
  final Function(List<String>?) onSelectionChanged;

  const _TopicChild(
      {required this.topic,
      this.selectedConcepts = const [],
      required this.onSelectionChanged});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ExpansionTile(
      tilePadding: const EdgeInsets.all(0),
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Checkbox(
              value: (topic.concepts!.length == selectedConcepts.length),
              onChanged: (value) {
                if (value ?? false) {
                  onSelectionChanged((topic.concepts ?? []).toList());
                } else {
                  onSelectionChanged([]);
                }
              },
            ),
            Expanded(child: Text(topic.topicName ?? ''))
          ],
        ),
      ),
      children: (topic.concepts ?? [])
          .map((concept) => Padding(
                padding: const EdgeInsets.only(
                    left: 24, top: 8, bottom: 8, right: 8),
                child: Row(
                  children: [
                    Checkbox(
                        value: (selectedConcepts).contains(concept),
                        onChanged: (value) {
                          if (value ?? false) {
                            selectedConcepts.add(concept);
                          } else {
                            selectedConcepts.remove(concept);
                          }
                          onSelectionChanged(selectedConcepts);
                        }),
                    Expanded(child: Text(concept))
                  ],
                ),
              ))
          .toList(),
    );
  }
}
