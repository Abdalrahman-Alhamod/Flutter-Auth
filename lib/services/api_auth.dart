import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiAuth {
  String baseUrl = 'https://a46b-5-155-136-252.ngrok-free.app/auth/';

  Future<void> signIn({required String email, required String password}) async {
    // decoding data into json body
    var body = {"email": email, "password": password};
    // getting url
    Uri url = Uri.parse('$baseUrl/signin.php');
    // sending request
    http.Response response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      debugPrint(response.body.toString());
      // connection success
      var data = jsonDecode(response.body);
      // if server sent an error
      if (data['statusCode'] != 200) {
        throw Exception(data['message']);
      }
    } else {
      // connection failure
      debugPrint(response.statusCode.toString());
      throw Exception('Error ${response.statusCode.toString()}');
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
      debugPrint(response.statusCode.toString());
      throw Exception('Error ${response.statusCode.toString()}');
    }
  }
}
