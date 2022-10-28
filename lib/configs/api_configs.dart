class ApiConfigs {
  static const String baseUrl =
      'utkwwq6r95.execute-api.us-east-1.amazonaws.com';

  //Headers
  static Map<String, String> defaultHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  static Map<String, String> getHeaders(String? token, String? userId) {
    if (token == null || token.isEmpty) {
      return defaultHeaders;
    } else {
      Map<String, String> tokenHeaders =
          Map<String, String>.from(defaultHeaders);
      tokenHeaders.addAll({'token': token});
      tokenHeaders.addAll({'userid': userId ?? ''});
      return tokenHeaders;
    }
  }
}
