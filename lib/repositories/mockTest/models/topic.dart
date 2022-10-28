import 'package:equatable/equatable.dart';

class Topic extends Equatable {
  String? topicName;
  List<String>? concepts;

  Topic({this.topicName, this.concepts});

  Topic.fromJson(Map<String, dynamic> json) {
    topicName = json['topicName'];
    concepts = json['concepts'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['topicName'] = topicName;
    data['concepts'] = concepts;
    return data;
  }

  @override
  List<Object?> get props => [topicName ?? '', concepts ?? []];
}
