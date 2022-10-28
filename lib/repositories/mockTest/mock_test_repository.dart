import 'dart:async';
import 'dart:convert';

import 'package:mock_test_app/configs/api_configs.dart';
import 'package:mock_test_app/repositories/mockTest/models/mock_test.dart';
import 'package:mock_test_app/repositories/mockTest/models/topic.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MockTestRepository {
  final StreamController<List<MockTest>> _controller = StreamController();

  static const String keyMockTestList = 'mockTestList';

  Stream<List<MockTest>> get mockTestList async* {

    List<MockTest> list = await _getList();
    yield list;

    yield* _controller.stream;
  }

  Future<List<Topic>> getTopics(String token, String userId) async {
    var response = await http.get(
        Uri.https(ApiConfigs.baseUrl, '/assignment/topics'),
        headers: ApiConfigs.getHeaders(token, userId));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json != null) {
        List<Topic> list = [];
        json.forEach((v) {
          list.add(Topic.fromJson(v));
        });
        return list;
      } else {
        throw Exception('Error Getting Topics');
      }
    } else {
      throw Exception('Error Getting Topics');
    }
  }

  Future<void> loadMockTestList() async {
    List<MockTest> list = await _getList();

    _controller.add(list);
  }

  Future<List<MockTest>> _getList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jsonString = preferences.getString(keyMockTestList);
    if (jsonString == null) {
      return [];
    }
    var json = jsonDecode(jsonString);
    List<MockTest> list = [];
    json.forEach((v) {
      list.add(MockTest.fromJson(v));
    });

    return list;
  }

  Future<void> createMockTest(MockTest mockTest) async {
    List<MockTest> list = await _getList();
    if (list.contains(mockTest)) {
      throw Exception('A test by the name ${mockTest.testName} already exists');
    }
    list.add(mockTest);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(keyMockTestList, jsonEncode(list));
  }
}
