import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiAuth {
  String baseUrl = '';

  Future<void> signIn({required String email, required String password}) async {
    // decoding data into json body
    var body = {"email": email, "password": password};
    // getting url
    Uri url = Uri.parse('$baseUrl/signin.php');
    // sending request
    http.Response response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      // connection success
      var data = jsonDecode(response.body);
      // if server sent an error
      if (data['statusCode'] != 200) {
        throw Exception(data['message']);
      }
    } else {
      // connection failure
      throw Exception('Error $response.statusCode');
    }
  }

  Future<void> register(
      {required String email, required String password}) async {
    // decoding data into json body
    var body = {"email": email, "password": password};
    // getting url
    Uri url = Uri.parse('$baseUrl/register.php');
    // sending request
    http.Response response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      // connection success
      var data = jsonDecode(response.body);
      // if server sent an error
      if (data['statusCode'] != 200) {
        throw Exception(data['message']);
      }
    } else {
      // connection failure
      throw Exception('Error $response.statusCode');
    }
  }
}
