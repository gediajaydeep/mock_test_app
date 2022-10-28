import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_test_app/repositories/mockTest/models/mock_test.dart';
import 'package:mock_test_app/utils/date_time_utils.dart';

import '../../../repositories/mockTest/models/topic.dart';
import '../../repositories/mockTest/mock_test_repository.dart';

part 'create_mock_test_event.dart';

part 'create_mock_test_state.dart';

class CreateMockTestBloc
    extends Bloc<CreateMockTestEvent, CreateMockTestState> {
  final MockTestRepository _mockTestRepository;

  CreateMockTestBloc(MockTestRepository mockTestRepository)
      : _mockTestRepository = mockTestRepository,
        super(const TopicsLoadingState()) {
    on<TopicListRequestedEvent>(_onTopicListRequested);
    on<CreateTestEvent>(_createTest);
    // Subscribe to repository stream
    // Register event Methods
  }

  @override
  Future<void> close() {
    return super.close();
  }

  Future<FutureOr<void>> _onTopicListRequested(
      TopicListRequestedEvent event, Emitter<CreateMockTestState> emit) async {
    try {
      List<Topic> topics = await _mockTestRepository.getTopics(
          'd61036c6-5ffd-4964-b7ff-8d5ba8ca0262',
          '25794905-2dd4-40bd-97b9-9d5d69294b86');
      emit(TopicsLoadedState(list: topics));
    } catch (e) {
      emit(TopicsLoadingErrorState(error: e.toString()));
    }
  }

  _createTest(CreateTestEvent event, Emitter<CreateMockTestState> emit) async {
    String validationError = _getValidationError(event.name, event.topics);

    if (validationError.isNotEmpty) {
      emit(ErrorState(error: validationError));
      return;
    }

    try {
      await _mockTestRepository.createMockTest(MockTest(
          testName: event.name,
          topics: event.topics,
          createdAt: DateTimeUtils.convertDateToString(DateTime.now())));
      _mockTestRepository.loadMockTestList();
      emit(const MockTestCreatedState());
    } catch (e) {
      emit(ErrorState(error: e.toString()));
    }
  }

  String _getValidationError(String name, List<Topic> topics) {
    if (name.trim().isEmpty) {
      return 'Name is required';
    }

    if (topics.isEmpty || _noConceptsSelected(topics)) {
      return 'Please select at least one topic';
    }
    return '';
  }

  bool _noConceptsSelected(List<Topic> topics) {
    for (Topic topic in topics) {
      if ((topic.concepts ?? []).isNotEmpty) {
        return false;
      }
    }
    return true;
  }
}
