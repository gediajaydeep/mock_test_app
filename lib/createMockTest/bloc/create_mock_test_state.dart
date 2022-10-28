part of 'create_mock_test_bloc.dart';

abstract class CreateMockTestState extends Equatable {
  const CreateMockTestState();

  @override
  List<Object> get props => [];
}

class TopicsLoadingState extends CreateMockTestState {
  const TopicsLoadingState();
}

class TopicsLoadingErrorState extends CreateMockTestState {
  final String error;

  const TopicsLoadingErrorState({required this.error});

  @override
  // TODO: implement props
  List<Object> get props => [error];
}

class TopicsLoadedState extends CreateMockTestState {
  final List<Topic> list;

  const TopicsLoadedState({required this.list});

  @override
  // TODO: implement props
  List<Object> get props => [list];
}

class ErrorState extends CreateMockTestState {
  final String error;

   const ErrorState({required this.error});

  @override
  // TODO: implement props
  List<Object> get props => [identityHashCode(this)];
}

class MockTestCreatedState extends CreateMockTestState {
  const MockTestCreatedState();
}
