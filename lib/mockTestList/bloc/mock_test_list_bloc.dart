import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/mockTest/mock_test_repository.dart';
import '../../repositories/mockTest/models/mock_test.dart';

part 'mock_test_list_event.dart';

part 'mock_test_list_state.dart';

class MockTestListBloc extends Bloc<MockTestListEvent, MockTestListState> {
  final MockTestRepository _mockTestRepository;

  late StreamSubscription _subscription;

  MockTestListBloc(MockTestRepository mockTestRepository)
      : _mockTestRepository = mockTestRepository,
        super(const ListLoadingState()) {
    on<ListLoadedEvent>(_listLoaded);
    _subscription = _mockTestRepository.mockTestList.listen((list) {
      if (list.isEmpty) {
        add(const ShowErrorEvent(error: 'No Test Available'));
        return;
      }
      add(ListLoadedEvent(list: list));
    });
    on<ListRequestedEvent>(_mockListRequested);

    on<ShowErrorEvent>(
      (event, emit) => emit(ErrorState(error: event.error)),
    );
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }

  FutureOr<void> _mockListRequested(
      ListRequestedEvent event, Emitter<MockTestListState> emit) {
    _mockTestRepository.loadMockTestList();
  }

  FutureOr<void> _listLoaded(ListLoadedEvent event, Emitter<MockTestListState> emit) {
    emit(const ListLoadingState());

    emit(ListLoadedState(list: event.list));
  }
}
