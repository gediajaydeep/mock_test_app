part of 'create_mock_test_bloc.dart';

abstract class CreateMockTestEvent extends Equatable {
  const CreateMockTestEvent();

  @override
  List<Object> get props => [];
}

class TopicListRequestedEvent extends CreateMockTestEvent {
  const TopicListRequestedEvent();
}

class CreateTestEvent extends CreateMockTestEvent {
  final String name;
  final List<Topic> topics;

  const CreateTestEvent({required this.name, required this.topics});

  @override
  // TODO: implement props
  List<Object> get props => [name, topics];
}
