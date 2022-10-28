part of 'mock_test_list_bloc.dart';

abstract class MockTestListState extends Equatable {
  const MockTestListState();

  @override
  List<Object> get props => [];
}

class ListLoadingState extends MockTestListState {
  const ListLoadingState();
}

class ErrorState extends MockTestListState {
  final String error;

  const ErrorState({required this.error});
}

class ListLoadedState extends MockTestListState {
  final List<MockTest> list;

  const ListLoadedState({required this.list});
}
