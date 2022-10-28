import 'package:equatable/equatable.dart';
import 'package:mock_test_app/repositories/mockTest/models/topic.dart';

class MockTest extends Equatable {
  String? testName;
  String? createdAt;
  List<Topic>? topics;

  MockTest({this.testName, this.createdAt, this.topics});

  MockTest.fromJson(Map<String, dynamic> json) {
    testName = json['testName'];
    createdAt = json['createdAt'];
    if (json['topics'] != null) {
      topics = <Topic>[];
      json['topics'].forEach((v) {
        topics!.add(Topic.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['testName'] = testName;
    data['createdAt'] = createdAt;
    if (topics != null) {
      data['topics'] = topics!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [testName ?? ''];
}
