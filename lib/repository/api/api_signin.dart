import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_config.dart';

class AuthService {
  Future<bool> loginUser(String nim, String password) async {
    final url = Uri.parse(ApiConfig.signInUrl);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'nim': nim, 'password': password}),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['status'] == 'success') {
        // Simpan data login ke SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userNIM', nim);
        // Simpan data lainnya yang dibutuhkan
        return true;
      } else {
        // Login gagal
        print(responseData['message']);
        return false;
      }
    } else {
      // Error saat menghubungi server
      print('Error: ${response.statusCode}');
      return false;
    }
  }
}
