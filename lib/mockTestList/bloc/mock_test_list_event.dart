part of 'mock_test_list_bloc.dart';

abstract class MockTestListEvent extends Equatable {
  const MockTestListEvent();

  @override
  List<Object> get props => [];
}

class ListRequestedEvent extends MockTestListEvent {
  const ListRequestedEvent();
}

class ListLoadedEvent extends MockTestListEvent {
  final List<MockTest> list;

  const ListLoadedEvent({required this.list});
}

class ShowErrorEvent extends MockTestListEvent {
  final String error;

  const ShowErrorEvent({required this.error});
}
