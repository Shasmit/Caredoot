import '../../constants/app_strings.dart';
import 'package:http/http.dart' as http;

import '../../helpers/user_helpers.dart';

class CustomHttpClient {
  http.Client client = http.Client();

  Future<http.Response> get(Uri url) async {
    var response = await client.get(url, headers: {
      STRING_CONTENT_TYPE: STRING_APPLICATION_JSON,
      STRING_ACCESS_TOKEN_KEY: UserHelpers.getAuthToken()
    });
    return response;
  }

  Future<http.Response> post(Uri url, var bodyData) async {
    var response = await client.post(url, body: bodyData, headers: {
      STRING_CONTENT_TYPE: STRING_APPLICATION_JSON,
      STRING_ACCESS_TOKEN_KEY: UserHelpers.getAuthToken()
    });

    return response;
  }

  Future<http.Response> delete(Uri url, var bodyData) async {
    var response = await client.delete(url, body: bodyData, headers: {
      STRING_CONTENT_TYPE: STRING_APPLICATION_JSON,
      STRING_ACCESS_TOKEN_KEY: UserHelpers.getAuthToken()
    });
    return response;
  }

  Future<http.Response> put(Uri url, var bodyData) async {
    var response = await client.put(url, body: bodyData, headers: {
      STRING_CONTENT_TYPE: STRING_APPLICATION_JSON,
      STRING_ACCESS_TOKEN_KEY: UserHelpers.getAuthToken()
    });
    return response;
  }
}
